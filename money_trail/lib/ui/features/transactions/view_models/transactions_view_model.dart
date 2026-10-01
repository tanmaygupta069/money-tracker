import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../data/repositories/transaction_repository.dart';
import '../../../../domain/models/money.dart';
import '../../../../domain/models/transaction.dart';

/// Drives the Transactions list and the manual-entry form. v0 shows the
/// current month.
class TransactionsViewModel extends ChangeNotifier {
  TransactionsViewModel({required TransactionRepository transactionRepository})
    : _transactionRepository = transactionRepository {
    _watchCurrentMonth();
  }

  final TransactionRepository _transactionRepository;

  StreamSubscription<List<Transaction>>? _subscription;

  final DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);
  List<Transaction> _transactions = const <Transaction>[];
  bool _isLoading = true;
  String? _error;

  DateTime get month => _month;
  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isEmpty => !_isLoading && _error == null && _transactions.isEmpty;

  Future<void> updateCategory(int id, String category) =>
      _transactionRepository.updateCategory(id, category);

  Future<void> delete(int id) => _transactionRepository.delete(id);

  /// Adds a GPay or Cash entry. Returns a message to show when the input is
  /// not usable, or null when the entry was stored.
  Future<String?> addManual({
    required String rupees,
    required TransactionSource source,
    String? merchant,
    String category = kUncategorized,
  }) async {
    final int? amountPaise = Money.rupeesToPaise(rupees.trim());
    if (amountPaise == null) return 'Enter an amount like 250 or 250.50.';
    if (amountPaise <= 0) return 'Enter an amount greater than zero.';

    final String? trimmedMerchant = merchant?.trim();
    await _transactionRepository.addManual(
      amountPaise: amountPaise,
      source: source,
      merchant: (trimmedMerchant == null || trimmedMerchant.isEmpty)
          ? null
          : trimmedMerchant,
      category: category,
    );
    return null;
  }

  void _watchCurrentMonth() {
    _subscription?.cancel();
    final DateTime start = _month;
    final DateTime end = DateTime(
      _month.year,
      _month.month + 1,
    ).subtract(const Duration(milliseconds: 1));

    _subscription = _transactionRepository.watchForRange(start, end).listen(
      (List<Transaction> transactions) {
        _transactions = transactions;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (Object _) {
        _error = 'Could not load transactions.';
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
