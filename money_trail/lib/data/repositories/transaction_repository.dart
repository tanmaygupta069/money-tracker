import 'package:drift/drift.dart';

import '../../domain/models/overview_snapshot.dart';
import '../../domain/models/transaction.dart';
import '../services/database/app_database.dart';
import '../services/database/database_service.dart';

/// Single source of truth for spends. Owns the row-to-domain mapping and the
/// insert-or-ignore dedup on `message_hash`.
class TransactionRepository {
  TransactionRepository(this._service);

  final DatabaseService _service;

  Stream<List<Transaction>> watchForRange(DateTime start, DateTime end) {
    return _service
        .watchTransactionsForRange(
          start.millisecondsSinceEpoch,
          end.millisecondsSinceEpoch,
        )
        .map(
          (List<TransactionRow> rows) =>
              rows.map(_toDomain).toList(growable: false),
        );
  }

  /// Re-aggregates whenever a transaction in the range changes. The Drift
  /// stream already fires on every write to the table, so it doubles as the
  /// trigger for the totals queries.
  Stream<OverviewSnapshot> watchOverview(DateTime start, DateTime end) {
    return _service
        .watchTransactionsForRange(
          start.millisecondsSinceEpoch,
          end.millisecondsSinceEpoch,
        )
        .asyncMap((_) => _loadOverview(start, end));
  }

  /// Returns false when the message hash was already stored.
  Future<bool> insert(Transaction transaction) async {
    final TransactionRow? inserted = await _service.insertTransactionOrIgnore(
      _toCompanion(transaction),
    );
    return inserted != null;
  }

  Future<void> updateCategory(int id, String category) =>
      _service.updateTransactionCategory(id, category);

  Future<void> delete(int id) => _service.deleteTransaction(id);

  Future<void> addManual({
    required int amountPaise,
    required TransactionSource source,
    String? merchant,
    String category = kUncategorized,
    DateTime? timestamp,
  }) async {
    final DateTime now = DateTime.now();
    await insert(
      Transaction(
        amountPaise: amountPaise,
        type: TransactionType.debit,
        source: source,
        merchant: merchant,
        category: category,
        txnTimestamp: timestamp ?? now,
        isManual: true,
        createdAt: now,
      ),
    );
  }

  Future<OverviewSnapshot> _loadOverview(DateTime start, DateTime end) async {
    final int startMillis = start.millisecondsSinceEpoch;
    final int endMillis = end.millisecondsSinceEpoch;

    final List<SourceTotalRow> sourceRows = await _service
        .getDebitTotalsBySource(startMillis, endMillis);
    final List<CategoryTotalRow> categoryRows = await _service
        .getDebitTotalsByCategory(startMillis, endMillis);
    final List<MerchantTotalRow> merchantRows = await _service.getTopMerchants(
      startMillis,
      endMillis,
    );

    final Map<TransactionSource, int> bySource = <TransactionSource, int>{
      for (final SourceTotalRow row in sourceRows)
        _sourceFromDb(row.source): row.total,
    };

    return OverviewSnapshot(
      month: DateTime(start.year, start.month),
      totalPaise: bySource.values.fold<int>(0, (int a, int b) => a + b),
      bySource: bySource,
      byCategory: categoryRows
          .map(
            (CategoryTotalRow row) =>
                (category: row.category, totalPaise: row.total),
          )
          .toList(growable: false),
      topMerchants: merchantRows
          .map(
            (MerchantTotalRow row) => (
              merchant: row.merchant,
              totalPaise: row.total,
              count: row.count,
            ),
          )
          .toList(growable: false),
    );
  }

  Transaction _toDomain(TransactionRow row) {
    return Transaction(
      id: row.id,
      amountPaise: row.amountPaise,
      type: _typeFromDb(row.type),
      source: _sourceFromDb(row.source),
      merchant: row.merchant,
      category: row.category,
      txnTimestamp: DateTime.fromMillisecondsSinceEpoch(row.txnTimestamp),
      isManual: row.isManual,
      rawSmsBody: row.rawSmsBody,
      sender: row.sender,
      messageHash: row.messageHash,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
    );
  }

  TransactionsCompanion _toCompanion(Transaction transaction) {
    return TransactionsCompanion.insert(
      amountPaise: transaction.amountPaise,
      type: _typeToDb(transaction.type),
      source: _sourceToDb(transaction.source),
      merchant: Value<String?>(transaction.merchant),
      category: Value<String>(transaction.category),
      txnTimestamp: transaction.txnTimestamp.millisecondsSinceEpoch,
      isManual: transaction.isManual,
      rawSmsBody: Value<String?>(transaction.rawSmsBody),
      sender: Value<String?>(transaction.sender),
      messageHash: Value<String?>(transaction.messageHash),
      createdAt: transaction.createdAt.millisecondsSinceEpoch,
    );
  }
}

// The uppercase wire values match the Kotlin `Converters` type converters, so a
// later native reader sees the same strings.

TransactionType _typeFromDb(String value) => switch (value.toUpperCase()) {
  'DEBIT' => TransactionType.debit,
  'CREDIT' => TransactionType.credit,
  _ => throw ArgumentError.value(value, 'type', 'Unknown transaction type'),
};

String _typeToDb(TransactionType value) => switch (value) {
  TransactionType.debit => 'DEBIT',
  TransactionType.credit => 'CREDIT',
};

TransactionSource _sourceFromDb(String value) => switch (value.toUpperCase()) {
  'KOTAK' => TransactionSource.kotak,
  'SLICE' => TransactionSource.slice,
  'GPAY_MANUAL' => TransactionSource.gpayManual,
  'CASH_MANUAL' => TransactionSource.cashManual,
  _ => throw ArgumentError.value(value, 'source', 'Unknown transaction source'),
};

String _sourceToDb(TransactionSource value) => switch (value) {
  TransactionSource.kotak => 'KOTAK',
  TransactionSource.slice => 'SLICE',
  TransactionSource.gpayManual => 'GPAY_MANUAL',
  TransactionSource.cashManual => 'CASH_MANUAL',
};
