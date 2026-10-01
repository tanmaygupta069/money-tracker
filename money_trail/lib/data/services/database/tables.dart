import 'package:drift/drift.dart';

/// Drift port of the Room schema in `tracker/data/entity/*.kt`.
///
/// Columns stay primitive (int / String / bool) and mirror SQLite exactly, so
/// the native Kotlin receiver and a possible later native reader see the same
/// shape. Enum and epoch-millis conversion happens in the repositories.

@DataClassName('TransactionRow')
@TableIndex(name: 'index_transactions_message_hash', columns: {#messageHash}, unique: true)
@TableIndex(name: 'index_transactions_txn_timestamp', columns: {#txnTimestamp})
class Transactions extends Table {
  @override
  String get tableName => 'transactions';

  IntColumn get id => integer().autoIncrement()();

  /// Integer paise, never a float.
  IntColumn get amountPaise => integer().named('amount_paise')();

  /// Uppercase enum name, `DEBIT` or `CREDIT`.
  TextColumn get type => text().named('type')();

  /// Uppercase enum name, `KOTAK`, `SLICE`, `GPAY_MANUAL` or `CASH_MANUAL`.
  TextColumn get source => text().named('source')();

  TextColumn get merchant => text().named('merchant').nullable()();

  // The literal has to stay inline: drift copies this expression verbatim into
  // the generated file, where `kUncategorized` is not in scope.
  TextColumn get category =>
      text().named('category').withDefault(const Constant('uncategorized'))();

  /// Epoch millis: the SMS timestamp, or entry time for manual rows.
  IntColumn get txnTimestamp => integer().named('txn_timestamp')();

  BoolColumn get isManual => boolean().named('is_manual')();

  TextColumn get rawSmsBody => text().named('raw_sms_body').nullable()();

  TextColumn get sender => text().named('sender').nullable()();

  /// sha256(body + timestamp). Null for manual rows, and SQLite permits many
  /// NULLs in a unique index, so manual entries never collide.
  TextColumn get messageHash => text().named('message_hash').nullable()();

  IntColumn get createdAt => integer().named('created_at')();
}

@DataClassName('CategoryRuleRow')
@TableIndex(name: 'index_category_rules_keyword', columns: {#keyword}, unique: true)
class CategoryRules extends Table {
  @override
  String get tableName => 'category_rules';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get keyword => text().named('keyword')();
  TextColumn get category => text().named('category')();
  IntColumn get priority =>
      integer().named('priority').withDefault(const Constant(0))();
}

@DataClassName('SenderAllowlistRow')
@TableIndex(name: 'index_sender_allowlist_name', columns: {#name}, unique: true)
class SenderAllowlist extends Table {
  @override
  String get tableName => 'sender_allowlist';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named('name')();
  BoolColumn get enabled =>
      boolean().named('enabled').withDefault(const Constant(true))();
}

@DataClassName('SyncStateRow')
class SyncStates extends Table {
  @override
  String get tableName => 'sync_state';

  /// Always [kSyncStateSingletonId]; the table holds exactly one row.
  IntColumn get id => integer().named('id')();

  /// Epoch millis, null when the inbox has never been synced.
  IntColumn get lastSyncedAt => integer().named('last_synced_at').nullable()();

  IntColumn get firstRunWindowDays =>
      integer().named('first_run_window_days').withDefault(const Constant(60))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Raw SMS parked by the native receiver and drained by Dart.
@DataClassName('InboxQueueRow')
class InboxQueue extends Table {
  @override
  String get tableName => 'inbox_queue';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get sender => text().named('sender')();
  TextColumn get body => text().named('body')();
  IntColumn get receivedAt => integer().named('received_at')();
}

/// The single `sync_state` row id, matching `SyncStateEntity.SINGLETON_ID`.
const int kSyncStateSingletonId = 1;
