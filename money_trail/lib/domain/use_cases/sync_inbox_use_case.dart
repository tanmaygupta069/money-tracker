import '../../data/models/parse_result.dart';
import '../../data/models/raw_sms.dart';
import '../../data/repositories/category_rule_repository.dart';
import '../../data/repositories/sender_allowlist_repository.dart';
import '../../data/repositories/sync_state_repository.dart';
import '../../data/repositories/transaction_repository.dart';
import '../../data/services/permission_service.dart';
import '../../data/services/sms_inbox_service.dart';
import '../../data/services/sms_queue_service.dart';
import '../models/category_rule.dart';
import '../models/sync_state.dart';
import '../models/transaction.dart';
import 'parse_sms_use_case.dart';

/// What one sync run did, so Settings can report it.
typedef SyncOutcome = ({bool permissionGranted, int scanned, int stored});

/// Catches up with the SMS inbox and drains whatever the native receiver
/// parked while the app was not running.
///
/// This is the reliability path: even if the receiver never fires, nothing is
/// lost as long as the message is still in the inbox.
class SyncInboxUseCase {
  const SyncInboxUseCase({
    required SmsInboxService inboxService,
    required SmsQueueService queueService,
    required PermissionService permissionService,
    required SenderAllowlistRepository allowlistRepository,
    required CategoryRuleRepository categoryRuleRepository,
    required SyncStateRepository syncStateRepository,
    required TransactionRepository transactionRepository,
    required ParseSmsUseCase parseSms,
  }) : _inboxService = inboxService,
       _queueService = queueService,
       _permissionService = permissionService,
       _allowlistRepository = allowlistRepository,
       _categoryRuleRepository = categoryRuleRepository,
       _syncStateRepository = syncStateRepository,
       _transactionRepository = transactionRepository,
       _parseSms = parseSms;

  final SmsInboxService _inboxService;
  final SmsQueueService _queueService;
  final PermissionService _permissionService;
  final SenderAllowlistRepository _allowlistRepository;
  final CategoryRuleRepository _categoryRuleRepository;
  final SyncStateRepository _syncStateRepository;
  final TransactionRepository _transactionRepository;
  final ParseSmsUseCase _parseSms;

  /// Reads everything newer than the last sync, or the first-run window when
  /// the inbox has never been synced.
  Future<SyncOutcome> call() async {
    if (!await _permissionService.hasSmsPermission()) {
      return (permissionGranted: false, scanned: 0, stored: 0);
    }

    final List<String> allowlist = await _allowlistRepository.getEnabledNames();
    final List<CategoryRule> rules = await _categoryRuleRepository.getAll();
    final SyncState state = await _syncStateRepository.get();

    final DateTime now = DateTime.now();
    final DateTime since =
        state.lastSyncedAt ??
        now.subtract(Duration(days: state.firstRunWindowDays));

    final List<RawSms> messages = await _inboxService.queryInbox(since);

    int stored = 0;
    for (final RawSms message in messages) {
      final bool inserted = await _parseAndStore(
        sender: message.sender,
        body: message.body,
        timestampMillis: message.timestampMillis,
        allowlist: allowlist,
        rules: rules,
      );
      if (inserted) stored++;
    }

    // Advanced even when messages were skipped: they are not transactions and
    // re-reading them would only repeat the same decision.
    await _syncStateRepository.save(state.copyWith(lastSyncedAt: now));

    return (
      permissionGranted: true,
      scanned: messages.length,
      stored: stored,
    );
  }

  /// Parses and clears the native queue. Returns how many rows were stored.
  Future<int> drainQueue() async {
    final List<QueuedSms> queued = await _queueService.drain();
    if (queued.isEmpty) return 0;

    final List<String> allowlist = await _allowlistRepository.getEnabledNames();
    final List<CategoryRule> rules = await _categoryRuleRepository.getAll();

    int stored = 0;
    for (final QueuedSms message in queued) {
      final bool inserted = await _parseAndStore(
        sender: message.sender,
        body: message.body,
        timestampMillis: message.receivedAt,
        allowlist: allowlist,
        rules: rules,
      );
      if (inserted) stored++;
    }

    // Skips are deleted too, otherwise an OTP would be reprocessed forever.
    await _queueService.deleteIds(
      queued.map((QueuedSms message) => message.id).toList(growable: false),
    );

    return stored;
  }

  Future<bool> _parseAndStore({
    required String sender,
    required String body,
    required int timestampMillis,
    required List<String> allowlist,
    required List<CategoryRule> rules,
  }) async {
    final ParseResult result = _parseSms(
      sender: sender,
      body: body,
      timestampMillis: timestampMillis,
      enabledAllowlistNames: allowlist,
      rules: rules,
    );

    return switch (result) {
      ParseSuccess(:final Transaction transaction) =>
        await _transactionRepository.insert(transaction),
      ParseSkipped() => false,
    };
  }
}
