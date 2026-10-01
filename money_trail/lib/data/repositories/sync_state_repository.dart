import '../../domain/models/sync_state.dart';
import '../services/database/app_database.dart';
import '../services/database/database_service.dart';

/// Where the next inbox sync resumes from.
class SyncStateRepository {
  SyncStateRepository(this._service);

  final DatabaseService _service;

  /// Falls back to the defaults when the singleton row is missing, which keeps
  /// a never-synced install behaving like a first run.
  Future<SyncState> get() async {
    final SyncStateRow? row = await _service.getSyncState();
    if (row == null) return const SyncState();

    final int? lastSyncedAt = row.lastSyncedAt;
    return SyncState(
      lastSyncedAt: (lastSyncedAt == null || lastSyncedAt == 0)
          ? null
          : DateTime.fromMillisecondsSinceEpoch(lastSyncedAt),
      firstRunWindowDays: row.firstRunWindowDays,
    );
  }

  Future<void> save(SyncState state) {
    return _service.upsertSyncState(
      lastSyncedAtMillis: state.lastSyncedAt?.millisecondsSinceEpoch,
      firstRunWindowDays: state.firstRunWindowDays,
    );
  }
}
