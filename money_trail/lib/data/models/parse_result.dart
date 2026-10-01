import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/transaction.dart';

part 'parse_result.freezed.dart';

/// Why a message did not become a transaction. Surfaced by the Settings tester.
enum SkipReason {
  senderNotAllowed,
  noAmount,
  notDebit,
  looksLikeOtp,
  looksLikePromo,
  creditOrRefund,
  unparseable,
}

/// Outcome of running one SMS through the parser.
@freezed
sealed class ParseResult with _$ParseResult {
  const factory ParseResult.success(Transaction transaction) = ParseSuccess;

  const factory ParseResult.skipped(SkipReason reason) = ParseSkipped;
}
