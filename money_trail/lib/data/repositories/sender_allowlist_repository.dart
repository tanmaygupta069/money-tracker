import 'package:drift/drift.dart';

import '../../domain/models/sender_allowlist_entry.dart';
import '../services/database/app_database.dart';
import '../services/database/database_service.dart';

/// Trusted sender names. An empty allowlist is allowed; sync then stores
/// nothing.
class SenderAllowlistRepository {
  SenderAllowlistRepository(this._service);

  final DatabaseService _service;

  Stream<List<SenderAllowlistEntry>> watchAll() {
    return _service.watchSenderAllowlist().map(
      (List<SenderAllowlistRow> rows) =>
          rows.map(_toDomain).toList(growable: false),
    );
  }

  /// Names used by the parser to decide whether a message is trusted.
  Future<List<String>> getEnabledNames() => _service.getEnabledSenderNames();

  Future<void> upsert(SenderAllowlistEntry entry) {
    return _service.upsertSenderAllowlistEntry(
      SenderAllowlistCompanion(
        id: entry.id == 0 ? const Value<int>.absent() : Value<int>(entry.id),
        name: Value<String>(entry.name.trim().toUpperCase()),
        enabled: Value<bool>(entry.enabled),
      ),
    );
  }

  Future<void> delete(int id) => _service.deleteSenderAllowlistEntry(id);

  SenderAllowlistEntry _toDomain(SenderAllowlistRow row) =>
      SenderAllowlistEntry(id: row.id, name: row.name, enabled: row.enabled);
}
