import 'package:freezed_annotation/freezed_annotation.dart';

import 'transaction.dart';

part 'overview_snapshot.freezed.dart';

typedef CategoryTotal = ({String category, int totalPaise});
typedef MerchantTotal = ({String merchant, int totalPaise, int count});

/// Everything the Overview screen shows for one month, already aggregated.
@freezed
abstract class OverviewSnapshot with _$OverviewSnapshot {
  const factory OverviewSnapshot({
    /// First instant of the month this snapshot covers.
    required DateTime month,
    required int totalPaise,
    required Map<TransactionSource, int> bySource,

    /// Sorted by total, descending.
    required List<CategoryTotal> byCategory,

    /// Top ten by total, descending.
    required List<MerchantTotal> topMerchants,
  }) = _OverviewSnapshot;
}
