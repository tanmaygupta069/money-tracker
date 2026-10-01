import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// Database file name, shared with the native receiver.
const String kDatabaseFileName = 'moneytrail.db';

@DriftDatabase(
  tables: [Transactions, CategoryRules, SenderAllowlist, SyncStates, InboxQueue],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Lets tests pass an in-memory executor.
  AppDatabase.withExecutor(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      // Every statement is `IF NOT EXISTS`, so a database the native receiver
      // already created for `inbox_queue` is filled in rather than rejected.
      await m.createAll();
      await _seed();
    },
  );

  Future<void> _seed() async {
    await batch((Batch batch) {
      batch.insertAll(senderAllowlist, <SenderAllowlistCompanion>[
        SenderAllowlistCompanion.insert(name: 'KOTAK'),
        SenderAllowlistCompanion.insert(name: 'SLICE'),
      ]);
      batch.insertAll(categoryRules, const <CategoryRulesCompanion>[
        CategoryRulesCompanion(
          keyword: Value('swiggy'),
          category: Value('food'),
          priority: Value(10),
        ),
        CategoryRulesCompanion(
          keyword: Value('zomato'),
          category: Value('food'),
          priority: Value(10),
        ),
        CategoryRulesCompanion(
          keyword: Value('uber'),
          category: Value('travel'),
          priority: Value(10),
        ),
        CategoryRulesCompanion(
          keyword: Value('ola'),
          category: Value('travel'),
          priority: Value(10),
        ),
        CategoryRulesCompanion(
          keyword: Value('electricity'),
          category: Value('bills'),
          priority: Value(10),
        ),
        CategoryRulesCompanion(
          keyword: Value('jio'),
          category: Value('bills'),
          priority: Value(5),
        ),
        CategoryRulesCompanion(
          keyword: Value('amazon'),
          category: Value('shopping'),
          priority: Value(5),
        ),
        CategoryRulesCompanion(
          keyword: Value('flipkart'),
          category: Value('shopping'),
          priority: Value(5),
        ),
      ]);
      batch.insert(
        syncStates,
        SyncStatesCompanion.insert(id: const Value(kSyncStateSingletonId)),
      );
    });
  }
}

/// Opens `moneytrail.db` in the application documents directory.
///
/// On Android that resolves to `context.getDir("flutter", MODE_PRIVATE)`, which
/// is exactly the directory `SmsQueueHelper` opens from Kotlin.
QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return NativeDatabase.createInBackground(
      File(p.join(directory.path, kDatabaseFileName)),
    );
  });
}
