import 'package:flutter/services.dart';

import '../models/raw_sms.dart';

/// Reads and clears the `inbox_queue` rows written by the native receiver.
class SmsQueueService {
  SmsQueueService({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel('com.moneytrail.app/sms');

  final MethodChannel _channel;

  /// Every queued message, oldest first.
  Future<List<QueuedSms>> drain() async {
    try {
      final List<Map<Object?, Object?>>? rows = await _channel
          .invokeListMethod<Map<Object?, Object?>>('drainQueue');
      if (rows == null) return const <QueuedSms>[];

      return rows
          .map(
            (Map<Object?, Object?> row) => QueuedSms(
              id: (row['id'] as num?)?.toInt() ?? 0,
              sender: row['sender'] as String? ?? '',
              body: row['body'] as String? ?? '',
              receivedAt: (row['receivedAt'] as num?)?.toInt() ?? 0,
            ),
          )
          .toList(growable: false);
    } on PlatformException {
      return const <QueuedSms>[];
    } on MissingPluginException {
      return const <QueuedSms>[];
    }
  }

  Future<void> deleteIds(List<int> ids) async {
    if (ids.isEmpty) return;
    try {
      await _channel.invokeMethod<void>('deleteQueueIds', <String, Object>{
        'ids': ids,
      });
    } on PlatformException {
      // Leaving rows behind is harmless: they are re-parsed and deduped.
    } on MissingPluginException {
      // Same as above.
    }
  }
}
