import 'package:flutter/services.dart';

import '../models/raw_sms.dart';

/// Reads the device SMS inbox. Returns raw messages; parsing happens in the
/// domain layer.
class SmsInboxService {
  SmsInboxService({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel('com.moneytrail.app/sms');

  static const int defaultLimit = 500;

  final MethodChannel _channel;

  /// Messages strictly newer than [since], newest first.
  ///
  /// Resolves to an empty list when the permission is missing, so callers never
  /// have to handle a platform failure.
  Future<List<RawSms>> queryInbox(DateTime since, {int limit = defaultLimit}) async {
    try {
      final List<Map<Object?, Object?>>? rows = await _channel
          .invokeListMethod<Map<Object?, Object?>>('queryInbox', <String, Object>{
            'sinceMillis': since.millisecondsSinceEpoch,
            'limit': limit,
          });
      if (rows == null) return const <RawSms>[];

      return rows
          .map(
            (Map<Object?, Object?> row) => RawSms(
              sender: row['sender'] as String? ?? '',
              body: row['body'] as String? ?? '',
              timestampMillis: (row['timestampMillis'] as num?)?.toInt() ?? 0,
            ),
          )
          .toList(growable: false);
    } on PlatformException {
      return const <RawSms>[];
    } on MissingPluginException {
      return const <RawSms>[];
    }
  }
}
