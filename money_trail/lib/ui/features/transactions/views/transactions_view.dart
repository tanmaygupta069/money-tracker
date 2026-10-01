import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/transaction.dart';
import '../../../core/formatters.dart';
import '../../../core/widgets/category_picker.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/money_text.dart';
import '../view_models/transactions_view_model.dart';
import 'add_manual_view.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionsViewModel viewModel = context.read<TransactionsViewModel>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const AddManualView()),
        ),
        tooltip: 'Add manual entry',
        child: const Icon(Icons.add),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, Widget? child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.error != null) {
            return EmptyState(icon: Icons.error_outline, title: viewModel.error!);
          }
          if (viewModel.isEmpty) {
            return EmptyState(
              icon: Icons.list_alt_outlined,
              title: 'No transactions in ${monthLabel(viewModel.month)}',
              message: 'Debit SMS appear here automatically.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 88),
            itemCount: viewModel.transactions.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (BuildContext context, int index) {
              return _TransactionTile(
                transaction: viewModel.transactions[index],
                viewModel: viewModel,
              );
            },
          );
        },
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction, required this.viewModel});

  final Transaction transaction;
  final TransactionsViewModel viewModel;

  Future<void> _editCategory(BuildContext context) async {
    final String? category = await showCategoryPicker(
      context,
      selected: transaction.category,
    );
    if (category == null) return;
    await viewModel.updateCategory(transaction.id, category);
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete transaction?'),
        content: const Text('This cannot be undone.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await viewModel.delete(transaction.id);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ListTile(
      title: Text(
        transaction.merchant ?? (transaction.isManual ? 'Manual entry' : 'Unknown'),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${sourceLabel(transaction.source)} · ${dateTimeLabel(transaction.txnTimestamp)}',
        style: theme.textTheme.bodySmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MoneyText(
                transaction.amountPaise,
                style: theme.textTheme.titleSmall,
              ),
              ActionChip(
                label: Text(categoryLabel(transaction.category)),
                visualDensity: VisualDensity.compact,
                onPressed: () => _editCategory(context),
              ),
            ],
          ),
          IconButton(
            onPressed: () => _confirmDelete(context),
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete',
          ),
        ],
      ),
    );
  }
}
