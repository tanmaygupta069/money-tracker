import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/transaction.dart';
import '../../../core/formatters.dart';
import '../../../core/widgets/category_picker.dart';
import '../view_models/transactions_view_model.dart';

/// GPay and Cash have no SMS, so they are entered by hand.
class AddManualView extends StatefulWidget {
  const AddManualView({super.key});

  @override
  State<AddManualView> createState() => _AddManualViewState();
}

class _AddManualViewState extends State<AddManualView> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _merchantController = TextEditingController();

  TransactionSource _source = TransactionSource.gpayManual;
  String _category = kUncategorized;
  bool _isSaving = false;

  @override
  void dispose() {
    _amountController.dispose();
    _merchantController.dispose();
    super.dispose();
  }

  Future<void> _pickCategory() async {
    final String? category = await showCategoryPicker(
      context,
      selected: _category,
    );
    if (category != null) setState(() => _category = category);
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);

    final String? failure = await context.read<TransactionsViewModel>().addManual(
      rupees: _amountController.text,
      source: _source,
      merchant: _merchantController.text,
      category: _category,
    );

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (failure != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure)));
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add manual entry')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: _amountController,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
            ],
            decoration: const InputDecoration(
              labelText: 'Amount in rupees',
              prefixText: '₹ ',
              hintText: '250.00',
            ),
          ),
          const SizedBox(height: 20),
          SegmentedButton<TransactionSource>(
            segments: <ButtonSegment<TransactionSource>>[
              ButtonSegment<TransactionSource>(
                value: TransactionSource.gpayManual,
                label: Text(sourceLabel(TransactionSource.gpayManual)),
              ),
              ButtonSegment<TransactionSource>(
                value: TransactionSource.cashManual,
                label: Text(sourceLabel(TransactionSource.cashManual)),
              ),
            ],
            selected: <TransactionSource>{_source},
            onSelectionChanged: (Set<TransactionSource> selection) =>
                setState(() => _source = selection.first),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _merchantController,
            decoration: const InputDecoration(
              labelText: 'Merchant (optional)',
              hintText: 'Chai stall',
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Category'),
            subtitle: Text(categoryLabel(_category)),
            trailing: const Icon(Icons.chevron_right),
            onTap: _pickCategory,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _isSaving ? null : _save,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
