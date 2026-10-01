import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

/// Category used until a keyword rule or the user says otherwise.
const String kUncategorized = 'uncategorized';

/// Categories offered in the pickers. Users may still type a free-text one.
const List<String> kKnownCategories = <String>[
  'food',
  'travel',
  'bills',
  'shopping',
  kUncategorized,
];

enum TransactionType { debit, credit }

enum TransactionSource { kotak, slice, gpayManual, cashManual }

/// A single spend. Amounts are integer paise, never floats.
@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    /// 0 until the row has been inserted.
    @Default(0) int id,
    required int amountPaise,
    required TransactionType type,
    required TransactionSource source,

    /// Null when the merchant could not be extracted or was left blank.
    String? merchant,
    @Default(kUncategorized) String category,

    /// SMS timestamp, or entry time for manual rows.
    required DateTime txnTimestamp,
    required bool isManual,

    /// The next three are always null for manual rows, which keeps manual
    /// entries out of the message_hash uniqueness check entirely.
    String? rawSmsBody,
    String? sender,
    String? messageHash,
    required DateTime createdAt,
  }) = _Transaction;
}
