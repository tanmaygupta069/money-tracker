import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../data/models/parse_result.dart';
import '../../../../data/repositories/category_rule_repository.dart';
import '../../../../data/repositories/sender_allowlist_repository.dart';
import '../../../../data/services/permission_service.dart';
import '../../../../domain/models/category_rule.dart';
import '../../../../domain/models/money.dart';
import '../../../../domain/models/sender_allowlist_entry.dart';
import '../../../../domain/use_cases/parse_sms_use_case.dart';
import '../../../../domain/use_cases/sync_inbox_use_case.dart';
import '../../../core/formatters.dart';

/// Drives Settings: permission state, the sender allowlist, manual sync and the
/// paste-an-SMS tester.
class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel({
    required PermissionService permissionService,
    required SenderAllowlistRepository allowlistRepository,
    required CategoryRuleRepository categoryRuleRepository,
    required SyncInboxUseCase syncInbox,
    required ParseSmsUseCase parseSms,
  }) : _permissionService = permissionService,
       _allowlistRepository = allowlistRepository,
       _categoryRuleRepository = categoryRuleRepository,
       _syncInbox = syncInbox,
       _parseSms = parseSms {
    _subscription = _allowlistRepository.watchAll().listen((
      List<SenderAllowlistEntry> entries,
    ) {
      _allowlist = entries;
      notifyListeners();
    });
  }

  final PermissionService _permissionService;
  final SenderAllowlistRepository _allowlistRepository;
  final CategoryRuleRepository _categoryRuleRepository;
  final SyncInboxUseCase _syncInbox;
  final ParseSmsUseCase _parseSms;

  StreamSubscription<List<SenderAllowlistEntry>>? _subscription;

  bool _hasSmsPermission = false;
  List<SenderAllowlistEntry> _allowlist = const <SenderAllowlistEntry>[];
  bool _isSyncing = false;
  String? _syncMessage;
  String? _testOutput;

  bool get hasSmsPermission => _hasSmsPermission;
  List<SenderAllowlistEntry> get allowlist => _allowlist;
  bool get isSyncing => _isSyncing;
  String? get syncMessage => _syncMessage;
  String? get testOutput => _testOutput;

  String get permissionLabel =>
      _hasSmsPermission ? 'SMS permission: granted' : 'SMS permission: denied';

  /// Refreshes the permission row; cheap enough to call whenever the screen
  /// appears or the app resumes.
  Future<void> refresh() async {
    final bool granted = await _permissionService.hasSmsPermission();
    if (granted == _hasSmsPermission) return;
    _hasSmsPermission = granted;
    notifyListeners();
  }

  Future<void> requestPermission() async {
    _hasSmsPermission = await _permissionService.requestSmsPermission();
    notifyListeners();
    if (_hasSmsPermission) await syncNow();
  }

  /// Drains whatever the receiver queued, then reads the inbox.
  Future<void> syncNow() async {
    if (_isSyncing) return;
    _isSyncing = true;
    _syncMessage = null;
    notifyListeners();

    try {
      await _syncInbox.drainQueue();
      final SyncOutcome outcome = await _syncInbox();
      _hasSmsPermission = outcome.permissionGranted;
      _syncMessage = outcome.permissionGranted
          ? 'Read ${outcome.scanned} messages, stored ${outcome.stored}.'
          : 'Grant the SMS permission to sync.';
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }

  Future<void> addSender(String name) async {
    final String trimmed = name.trim();
    if (trimmed.isEmpty) return;
    await _allowlistRepository.upsert(SenderAllowlistEntry(name: trimmed));
  }

  Future<void> toggleSender(SenderAllowlistEntry entry) =>
      _allowlistRepository.upsert(entry.copyWith(enabled: !entry.enabled));

  Future<void> removeSender(int id) => _allowlistRepository.delete(id);

  /// Runs the real parser over pasted text. Nothing is written to the database.
  Future<void> testParse(String rawSender, String rawBody) async {
    final List<String> allowlist = await _allowlistRepository.getEnabledNames();
    final List<CategoryRule> rules = await _categoryRuleRepository.getAll();

    final ParseResult result = _parseSms(
      sender: rawSender.trim(),
      body: rawBody,
      timestampMillis: DateTime.now().millisecondsSinceEpoch,
      enabledAllowlistNames: allowlist,
      rules: rules,
    );

    _testOutput = switch (result) {
      ParseSkipped(:final SkipReason reason) => 'Skipped: ${_skipLabel(reason)}',
      ParseSuccess(:final transaction) => <String>[
        'Amount: ${Money.paiseToRupeeLabel(transaction.amountPaise)}',
        'Merchant: ${transaction.merchant ?? 'not found'}',
        'Source: ${sourceLabel(transaction.source)}',
        'Category: ${transaction.category}',
        'Hash: ${transaction.messageHash}',
      ].join('\n'),
    };
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

String _skipLabel(SkipReason reason) => switch (reason) {
  SkipReason.senderNotAllowed => 'sender is not on the allowlist',
  SkipReason.noAmount => 'no amount found',
  SkipReason.notDebit => 'no debit keyword',
  SkipReason.looksLikeOtp => 'looks like an OTP',
  SkipReason.looksLikePromo => 'looks promotional',
  SkipReason.creditOrRefund => 'credit or refund, not tracked in v0',
  SkipReason.unparseable => 'could not be read',
};
