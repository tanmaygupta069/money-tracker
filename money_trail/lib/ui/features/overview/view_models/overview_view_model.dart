import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../data/repositories/transaction_repository.dart';
import '../../../../domain/models/overview_snapshot.dart';
import '../../../../domain/models/transaction.dart';
import '../../../../domain/use_cases/sync_inbox_use_case.dart';

/// Drives the Overview screen: one month at a time, aggregated by the
/// repository.
class OverviewViewModel extends ChangeNotifier {
  OverviewViewModel({
    required TransactionRepository transactionRepository,
    required SyncInboxUseCase syncInbox,
  }) : _transactionRepository = transactionRepository,
       _syncInbox = syncInbox {
    _watchSelectedMonth();
  }

  final TransactionRepository _transactionRepository;
  final SyncInboxUseCase _syncInbox;

  StreamSubscription<OverviewSnapshot>? _subscription;

  DateTime _month = _firstOfMonth(DateTime.now());
  OverviewSnapshot? _snapshot;
  bool _isLoading = true;
  String? _error;
  bool _isSyncing = false;

  DateTime get month => _month;
  OverviewSnapshot? get snapshot => _snapshot;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// The next arrow stays disabled on the current month.
  bool get canGoForward => _month.isBefore(_firstOfMonth(DateTime.now()));

  int get totalPaise => _snapshot?.totalPaise ?? 0;

  List<CategoryTotal> get byCategory =>
      _snapshot?.byCategory ?? const <CategoryTotal>[];

  List<MerchantTotal> get topMerchants =>
      _snapshot?.topMerchants ?? const <MerchantTotal>[];

  int paiseFor(TransactionSource source) => _snapshot?.bySource[source] ?? 0;

  /// GPay and Cash entries shown as one "Manual" figure.
  int get manualPaise =>
      paiseFor(TransactionSource.gpayManual) +
      paiseFor(TransactionSource.cashManual);

  bool get isEmpty => !_isLoading && _error == null && totalPaise == 0;

  void previousMonth() => _selectMonth(DateTime(_month.year, _month.month - 1));

  void nextMonth() {
    if (!canGoForward) return;
    _selectMonth(DateTime(_month.year, _month.month + 1));
  }

  /// Drains anything the receiver queued, then catches up with the inbox. The
  /// snapshot stream picks up whatever this stores.
  Future<void> syncFromInbox() async {
    if (_isSyncing) return;
    _isSyncing = true;
    try {
      await _syncInbox.drainQueue();
      await _syncInbox();
    } finally {
      _isSyncing = false;
    }
  }

  void _selectMonth(DateTime month) {
    _month = _firstOfMonth(month);
    _watchSelectedMonth();
  }

  void _watchSelectedMonth() {
    _subscription?.cancel();
    _isLoading = true;
    _error = null;
    notifyListeners();

    final DateTime start = _month;
    // Inclusive end of the month, so neighbouring months never overlap.
    final DateTime end = DateTime(
      _month.year,
      _month.month + 1,
    ).subtract(const Duration(milliseconds: 1));

    _subscription = _transactionRepository.watchOverview(start, end).listen(
      (OverviewSnapshot snapshot) {
        _snapshot = snapshot;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (Object _) {
        _error = 'Could not load this month.';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

DateTime _firstOfMonth(DateTime date) => DateTime(date.year, date.month);
