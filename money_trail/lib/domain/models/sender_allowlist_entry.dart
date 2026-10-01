import 'package:freezed_annotation/freezed_annotation.dart';

part 'sender_allowlist_entry.freezed.dart';

/// A trusted sender-ID name, matched after the carrier prefix is stripped.
@freezed
abstract class SenderAllowlistEntry with _$SenderAllowlistEntry {
  const factory SenderAllowlistEntry({
    @Default(0) int id,

    /// e.g. `KOTAK`, which matches sender IDs such as `VM-KOTAKB`.
    required String name,
    @Default(true) bool enabled,
  }) = _SenderAllowlistEntry;
}
