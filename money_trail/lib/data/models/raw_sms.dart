import 'package:freezed_annotation/freezed_annotation.dart';

part 'raw_sms.freezed.dart';

/// A message as read from the device SMS inbox.
@freezed
abstract class RawSms with _$RawSms {
  const factory RawSms({
    required String sender,
    required String body,
    required int timestampMillis,
  }) = _RawSms;
}

/// A row the native receiver parked in `inbox_queue`.
@freezed
abstract class QueuedSms with _$QueuedSms {
  const factory QueuedSms({
    required int id,
    required String sender,
    required String body,
    required int receivedAt,
  }) = _QueuedSms;
}
