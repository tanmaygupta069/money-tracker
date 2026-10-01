import 'package:drift/drift.dart';

import 'app_database.dart';
import 'tables.dart';

/// Aggregate shapes returned by the overview queries.
typedef SourceTotalRow = ({String source, int total});
typedef CategoryTotalRow = ({String category, int total});
typedef MerchantTotalRow = ({String merchant, int total, int count});

/// Thin wrapper over Drift. Returns raw rows; repositories own the mapping to
/// domain models. This is a port of the DAOs in `tracker/data/dao/*.kt`.
class DatabaseService {
  DatabaseService(this._db);

  final AppDatabase _db;

  // ---------------------------------------------------------------- transactions

  Stream<List<TransactionRow>> watchTransactionsForRange(
    int startMillis,
    int endMillis,
  ) {
    final SimpleSelectStatement<Transactions, TransactionRow> query =
        _db.select(_db.transactions)
          ..where(
            (Transactions t) =>
                t.txnTimestamp.isBetweenValues(startMillis, endMillis),
          )
          ..orderBy([
            (Transactions t) => OrderingTerm.desc(t.txnTimestamp),
          ]);
    return query.watch();
  }

  /// Inserts unless the `message_hash` unique index already holds the row.
  /// Returns null when the duplicate was ignored.
  Future<TransactionRow?> insertTransactionOrIgnore(
    TransactionsCompanion row,
  ) {
    return _db
        .into(_db.transactions)
        .insertReturningOrNull(row, mode: InsertMode.insertOrIgnore);
  }

  Future<void> updateTransactionCategory(int id, String category) async {
    await (_db.update(_db.transactions)
          ..where((Transactions t) => t.id.equals(id)))
        .write(TransactionsCompanion(category: Value(category)));
  }

  Future<void> deleteTransaction(int id) async {
    await (_db.delete(_db.transactions)
          ..where((Transactions t) => t.id.equals(id)))
        .go();
  }

  Future<List<SourceTotalRow>> getDebitTotalsBySource(
    int startMillis,
    int endMillis,
  ) async {
    final List<QueryRow> rows = await _db
        .customSelect(
          'SELECT source, SUM(amount_paise) AS total FROM transactions '
          "WHERE type = 'DEBIT' AND txn_timestamp BETWEEN ? AND ? "
          'GROUP BY source',
          variables: <Variable<Object>>[
            Variable.withInt(startMillis),
            Variable.withInt(endMillis),
          ],
          readsFrom: <ResultSetImplementation<Object, Object>>{_db.transactions},
        )
        .get();
    return rows
        .map(
          (QueryRow row) => (
            source: row.read<String>('source'),
            total: row.read<int>('total'),
          ),
        )
        .toList(growable: false);
  }

  Future<List<CategoryTotalRow>> getDebitTotalsByCategory(
    int startMillis,
    int endMillis,
  ) async {
    final List<QueryRow> rows = await _db
        .customSelect(
          'SELECT category, SUM(amount_paise) AS total FROM transactions '
          "WHERE type = 'DEBIT' AND txn_timestamp BETWEEN ? AND ? "
          'GROUP BY category ORDER BY total DESC',
          variables: <Variable<Object>>[
            Variable.withInt(startMillis),
            Variable.withInt(endMillis),
          ],
          readsFrom: <ResultSetImplementation<Object, Object>>{_db.transactions},
        )
        .get();
    return rows
        .map(
          (QueryRow row) => (
            category: row.read<String>('category'),
            total: row.read<int>('total'),
          ),
        )
        .toList(growable: false);
  }

  Future<List<MerchantTotalRow>> getTopMerchants(
    int startMillis,
    int endMillis, {
    int limit = 10,
  }) async {
    final List<QueryRow> rows = await _db
        .customSelect(
          'SELECT merchant, SUM(amount_paise) AS total, COUNT(*) AS count '
          'FROM transactions '
          "WHERE type = 'DEBIT' AND merchant IS NOT NULL "
          'AND txn_timestamp BETWEEN ? AND ? '
          'GROUP BY merchant ORDER BY total DESC LIMIT ?',
          variables: <Variable<Object>>[
            Variable.withInt(startMillis),
            Variable.withInt(endMillis),
            Variable.withInt(limit),
          ],
          readsFrom: <ResultSetImplementation<Object, Object>>{_db.transactions},
        )
        .get();
    return rows
        .map(
          (QueryRow row) => (
            merchant: row.read<String>('merchant'),
            total: row.read<int>('total'),
            count: row.read<int>('count'),
          ),
        )
        .toList(growable: false);
  }

  // -------------------------------------------------------------- category rules

  Stream<List<CategoryRuleRow>> watchCategoryRules() {
    return (_db.select(_db.categoryRules)
          ..orderBy([
            (CategoryRules r) => OrderingTerm.desc(r.priority),
          ]))
        .watch();
  }

  Future<List<CategoryRuleRow>> getCategoryRules() {
    return (_db.select(_db.categoryRules)
          ..orderBy([
            (CategoryRules r) => OrderingTerm.desc(r.priority),
          ]))
        .get();
  }

  Future<void> upsertCategoryRule(CategoryRulesCompanion row) async {
    await _db
        .into(_db.categoryRules)
        .insert(row, mode: InsertMode.insertOrReplace);
  }

  Future<void> deleteCategoryRule(int id) async {
    await (_db.delete(_db.categoryRules)
          ..where((CategoryRules r) => r.id.equals(id)))
        .go();
  }

  // ------------------------------------------------------------ sender allowlist

  Stream<List<SenderAllowlistRow>> watchSenderAllowlist() {
    return (_db.select(_db.senderAllowlist)
          ..orderBy([
            (SenderAllowlist s) => OrderingTerm.asc(s.name),
          ]))
        .watch();
  }

  Future<List<String>> getEnabledSenderNames() async {
    final JoinedSelectStatement<SenderAllowlist, SenderAllowlistRow> query =
        _db.selectOnly(_db.senderAllowlist)
          ..addColumns(<Expression<Object>>[_db.senderAllowlist.name])
          ..where(_db.senderAllowlist.enabled.equals(true));
    final List<TypedResult> rows = await query.get();
    return rows
        .map((TypedResult row) => row.read(_db.senderAllowlist.name)!)
        .toList(growable: false);
  }

  Future<void> upsertSenderAllowlistEntry(SenderAllowlistCompanion row) async {
    await _db
        .into(_db.senderAllowlist)
        .insert(row, mode: InsertMode.insertOrReplace);
  }

  Future<void> deleteSenderAllowlistEntry(int id) async {
    await (_db.delete(_db.senderAllowlist)
          ..where((SenderAllowlist s) => s.id.equals(id)))
        .go();
  }

  // ------------------------------------------------------------------ sync state

  Future<SyncStateRow?> getSyncState() {
    return (_db.select(_db.syncStates)
          ..where((SyncStates s) => s.id.equals(kSyncStateSingletonId)))
        .getSingleOrNull();
  }

  /// REPLACE on the fixed id keeps `sync_state` a true singleton row.
  Future<void> upsertSyncState({
    int? lastSyncedAtMillis,
    required int firstRunWindowDays,
  }) async {
    await _db
        .into(_db.syncStates)
        .insert(
          SyncStatesCompanion.insert(
            id: const Value(kSyncStateSingletonId),
            lastSyncedAt: Value(lastSyncedAtMillis),
            firstRunWindowDays: Value(firstRunWindowDays),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }
}
