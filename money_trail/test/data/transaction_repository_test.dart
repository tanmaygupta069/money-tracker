import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_trail/data/repositories/transaction_repository.dart';
import 'package:money_trail/data/services/database/app_database.dart';
import 'package:money_trail/data/services/database/database_service.dart';
import 'package:money_trail/domain/models/transaction.dart';

void main() {
  late AppDatabase database;
  late TransactionRepository repository;

  final DateTime start = DateTime(2026, 10);
  final DateTime end = DateTime(2026, 11).subtract(const Duration(milliseconds: 1));

  Transaction smsDebit({required String hash, int amountPaise = 25000}) {
    return Transaction(
      amountPaise: amountPaise,
      type: TransactionType.debit,
      source: TransactionSource.kotak,
      merchant: 'SWIGGY',
      category: 'food',
      txnTimestamp: DateTime(2026, 10, 2, 13, 30),
      isManual: false,
      rawSmsBody: 'Rs.250.00 debited to SWIGGY',
      sender: 'VM-KOTAKB',
      messageHash: hash,
      createdAt: DateTime(2026, 10, 2, 13, 31),
    );
  }

  setUp(() {
    database = AppDatabase.withExecutor(NativeDatabase.memory());
    repository = TransactionRepository(DatabaseService(database));
  });

  tearDown(() => database.close());

  test('insert stores a new message hash', () async {
    expect(await repository.insert(smsDebit(hash: 'hash-a')), isTrue);
    expect(await repository.watchForRange(start, end).first, hasLength(1));
  });

  test('a duplicate message hash cannot create a second row', () async {
    expect(await repository.insert(smsDebit(hash: 'hash-a')), isTrue);
    expect(await repository.insert(smsDebit(hash: 'hash-a')), isFalse);

    expect(await repository.watchForRange(start, end).first, hasLength(1));
  });

  test('manual entries never collide, because their hash is null', () async {
    await repository.addManual(
      amountPaise: 15000,
      source: TransactionSource.cashManual,
      timestamp: DateTime(2026, 10, 5, 9),
    );
    await repository.addManual(
      amountPaise: 15000,
      source: TransactionSource.gpayManual,
      timestamp: DateTime(2026, 10, 5, 9),
    );

    final List<Transaction> stored = await repository
        .watchForRange(start, end)
        .first;
    expect(stored, hasLength(2));
    expect(stored.every((Transaction t) => t.messageHash == null), isTrue);
    expect(stored.every((Transaction t) => t.isManual), isTrue);
  });

  test('round trips enums, paise and timestamps', () async {
    await repository.insert(smsDebit(hash: 'hash-b', amountPaise: 119900));

    final Transaction stored =
        (await repository.watchForRange(start, end).first).single;
    expect(stored.amountPaise, 119900);
    expect(stored.type, TransactionType.debit);
    expect(stored.source, TransactionSource.kotak);
    expect(stored.txnTimestamp, DateTime(2026, 10, 2, 13, 30));
    expect(stored.isManual, isFalse);
  });

  test('updateCategory and delete act on one row', () async {
    await repository.insert(smsDebit(hash: 'hash-c'));
    final Transaction stored =
        (await repository.watchForRange(start, end).first).single;

    await repository.updateCategory(stored.id, 'shopping');
    expect(
      (await repository.watchForRange(start, end).first).single.category,
      'shopping',
    );

    await repository.delete(stored.id);
    expect(await repository.watchForRange(start, end).first, isEmpty);
  });

  test('overview aggregates debits by source, category and merchant', () async {
    await repository.insert(smsDebit(hash: 'hash-d', amountPaise: 25000));
    await repository.addManual(
      amountPaise: 5000,
      source: TransactionSource.cashManual,
      merchant: 'Chai stall',
      category: 'food',
      timestamp: DateTime(2026, 10, 6, 10),
    );

    final snapshot = await repository.watchOverview(start, end).first;

    expect(snapshot.totalPaise, 30000);
    expect(snapshot.bySource[TransactionSource.kotak], 25000);
    expect(snapshot.bySource[TransactionSource.cashManual], 5000);
    expect(snapshot.byCategory.single, (category: 'food', totalPaise: 30000));
    expect(snapshot.topMerchants, hasLength(2));
    expect(snapshot.topMerchants.first.merchant, 'SWIGGY');
    expect(snapshot.month, DateTime(2026, 10));
  });
}
