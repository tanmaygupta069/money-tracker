import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_state.freezed.dart';

/// Where the next inbox sync should resume from.
@freezed
abstract class SyncState with _$SyncState {
  const factory SyncState({
    /// Null means the inbox has never been synced.
    DateTime? lastSyncedAt,

    /// How far back the very first sync reaches.
    @Default(60) int firstRunWindowDays,
  }) = _SyncState;
}
