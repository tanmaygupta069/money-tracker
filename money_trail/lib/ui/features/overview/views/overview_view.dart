import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/overview_snapshot.dart';
import '../../../../domain/models/transaction.dart';
import '../../../core/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/money_text.dart';
import '../../../core/widgets/month_switcher.dart';
import '../../../core/widgets/share_bar.dart';
import '../view_models/overview_view_model.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final OverviewViewModel viewModel = context.read<OverviewViewModel>();

    return ListenableBuilder(
      listenable: viewModel,
      builder: (BuildContext context, Widget? child) {
        return Column(
          children: <Widget>[
            MonthSwitcher(
              month: viewModel.month,
              onPrevious: viewModel.previousMonth,
              onNext: viewModel.canGoForward ? viewModel.nextMonth : null,
            ),
            Expanded(child: _body(context, viewModel)),
          ],
        );
      },
    );
  }

  Widget _body(BuildContext context, OverviewViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.error != null) {
      return EmptyState(
        icon: Icons.error_outline,
        title: viewModel.error!,
      );
    }
    if (viewModel.isEmpty) {
      return const EmptyState(
        icon: Icons.receipt_long_outlined,
        title: 'Nothing spent this month',
        message: 'Bank SMS are read on open. You can also add a manual entry.',
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: <Widget>[
        _TotalCard(totalPaise: viewModel.totalPaise),
        const SizedBox(height: 16),
        _SourceRow(viewModel: viewModel),
        const SizedBox(height: 24),
        _CategoryBreakdown(
          categories: viewModel.byCategory,
          totalPaise: viewModel.totalPaise,
        ),
        const SizedBox(height: 24),
        _TopMerchants(merchants: viewModel.topMerchants),
      ],
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({required this.totalPaise});

  final int totalPaise;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Total spend',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            MoneyText(
              totalPaise,
              style: theme.textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SourceRow extends StatelessWidget {
  const _SourceRow({required this.viewModel});

  final OverviewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _SourceTile(
          label: sourceLabel(TransactionSource.kotak),
          paise: viewModel.paiseFor(TransactionSource.kotak),
        ),
        _SourceTile(
          label: sourceLabel(TransactionSource.slice),
          paise: viewModel.paiseFor(TransactionSource.slice),
        ),
        _SourceTile(label: 'Manual', paise: viewModel.manualPaise),
      ],
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({required this.label, required this.paise});

  final String label;
  final int paise;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Expanded(
      child: Card(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: theme.textTheme.labelMedium),
              const SizedBox(height: 4),
              MoneyText(paise, style: theme.textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryBreakdown extends StatelessWidget {
  const _CategoryBreakdown({required this.categories, required this.totalPaise});

  final List<CategoryTotal> categories;
  final int totalPaise;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('By category', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12),
        for (final CategoryTotal entry in categories)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      categoryLabel(entry.category),
                      style: theme.textTheme.bodyMedium,
                    ),
                    MoneyText(
                      entry.totalPaise,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ShareBar(
                  fraction: totalPaise == 0
                      ? 0
                      : entry.totalPaise / totalPaise,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _TopMerchants extends StatelessWidget {
  const _TopMerchants({required this.merchants});

  final List<MerchantTotal> merchants;

  @override
  Widget build(BuildContext context) {
    if (merchants.isEmpty) return const SizedBox.shrink();
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Top merchants', style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        for (final MerchantTotal entry in merchants)
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(entry.merchant),
            subtitle: Text(
              entry.count == 1 ? '1 payment' : '${entry.count} payments',
            ),
            trailing: MoneyText(entry.totalPaise),
          ),
      ],
    );
  }
}
