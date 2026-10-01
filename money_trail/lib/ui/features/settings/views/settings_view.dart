import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/sender_allowlist_entry.dart';
import '../view_models/settings_view_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final TextEditingController _senderController = TextEditingController();
  final TextEditingController _testSenderController = TextEditingController();
  final TextEditingController _testBodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SettingsViewModel>().refresh();
  }

  @override
  void dispose() {
    _senderController.dispose();
    _testSenderController.dispose();
    _testBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SettingsViewModel viewModel = context.read<SettingsViewModel>();

    return ListenableBuilder(
      listenable: viewModel,
      builder: (BuildContext context, Widget? child) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: <Widget>[
            _PermissionCard(viewModel: viewModel),
            const SizedBox(height: 24),
            _SyncCard(viewModel: viewModel),
            const SizedBox(height: 24),
            _AllowlistSection(
              viewModel: viewModel,
              controller: _senderController,
            ),
            const SizedBox(height: 24),
            _TesterSection(
              viewModel: viewModel,
              senderController: _testSenderController,
              bodyController: _testBodyController,
            ),
          ],
        );
      },
    );
  }
}

class _PermissionCard extends StatelessWidget {
  const _PermissionCard({required this.viewModel});

  final SettingsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: ListTile(
        leading: Icon(
          viewModel.hasSmsPermission ? Icons.verified_user : Icons.gpp_maybe,
          color: viewModel.hasSmsPermission
              ? theme.colorScheme.primary
              : theme.colorScheme.error,
        ),
        title: Text(viewModel.permissionLabel),
        subtitle: const Text('READ_SMS and RECEIVE_SMS, used only on-device.'),
        trailing: viewModel.hasSmsPermission
            ? null
            : TextButton(
                onPressed: viewModel.requestPermission,
                child: const Text('Grant'),
              ),
      ),
    );
  }
}

class _SyncCard extends StatelessWidget {
  const _SyncCard({required this.viewModel});

  final SettingsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FilledButton.tonalIcon(
          onPressed: viewModel.isSyncing ? null : viewModel.syncNow,
          icon: viewModel.isSyncing
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.sync),
          label: Text(viewModel.isSyncing ? 'Syncing…' : 'Sync now'),
        ),
        if (viewModel.syncMessage != null) ...<Widget>[
          const SizedBox(height: 8),
          Text(
            viewModel.syncMessage!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}

class _AllowlistSection extends StatelessWidget {
  const _AllowlistSection({required this.viewModel, required this.controller});

  final SettingsViewModel viewModel;
  final TextEditingController controller;

  Future<void> _add() async {
    await viewModel.addSender(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Trusted senders', style: theme.textTheme.titleMedium),
        Text(
          'Matched after the carrier prefix is stripped, so KOTAK covers '
          'VM-KOTAKB.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        for (final SenderAllowlistEntry entry in viewModel.allowlist)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(entry.name),
            leading: Switch(
              value: entry.enabled,
              onChanged: (_) => viewModel.toggleSender(entry),
            ),
            trailing: IconButton(
              onPressed: () => viewModel.removeSender(entry.id),
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Remove',
            ),
          ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: controller,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Add a sender name',
                  hintText: 'HDFC',
                ),
                onSubmitted: (_) => _add(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filledTonal(
              onPressed: _add,
              icon: const Icon(Icons.add),
              tooltip: 'Add sender',
            ),
          ],
        ),
      ],
    );
  }
}

class _TesterSection extends StatelessWidget {
  const _TesterSection({
    required this.viewModel,
    required this.senderController,
    required this.bodyController,
  });

  final SettingsViewModel viewModel;
  final TextEditingController senderController;
  final TextEditingController bodyController;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Test a message', style: theme.textTheme.titleMedium),
        Text(
          'Shows how the parser reads an SMS. Nothing is saved.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: senderController,
          decoration: const InputDecoration(
            labelText: 'Sender',
            hintText: 'VM-KOTAKB',
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: bodyController,
          minLines: 3,
          maxLines: 6,
          decoration: const InputDecoration(
            labelText: 'Message body',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => viewModel.testParse(
            senderController.text,
            bodyController.text,
          ),
          child: const Text('Parse'),
        ),
        if (viewModel.testOutput != null) ...<Widget>[
          const SizedBox(height: 12),
          Card(
            color: theme.colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                viewModel.testOutput!,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
