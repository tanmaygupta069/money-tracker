import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'data/repositories/category_rule_repository.dart';
import 'data/repositories/sender_allowlist_repository.dart';
import 'data/repositories/sync_state_repository.dart';
import 'data/repositories/transaction_repository.dart';
import 'data/services/database/app_database.dart';
import 'data/services/database/database_service.dart';
import 'data/services/permission_service.dart';
import 'data/services/sms_inbox_service.dart';
import 'data/services/sms_queue_service.dart';
import 'domain/use_cases/categorize_merchant_use_case.dart';
import 'domain/use_cases/parse_sms_use_case.dart';
import 'domain/use_cases/sync_inbox_use_case.dart';
import 'ui/features/overview/view_models/overview_view_model.dart';
import 'ui/features/settings/view_models/settings_view_model.dart';
import 'ui/features/transactions/view_models/transactions_view_model.dart';

/// The whole object graph, wired bottom-up: services, then repositories, then
/// use cases, then ViewModels. Everything is constructor injected.
List<SingleChildWidget> appProviders(AppDatabase database) {
  return <SingleChildWidget>[
    Provider<AppDatabase>.value(value: database),

    // Services.
    Provider<DatabaseService>(
      create: (BuildContext context) =>
          DatabaseService(context.read<AppDatabase>()),
    ),
    Provider<SmsInboxService>(create: (_) => SmsInboxService()),
    Provider<SmsQueueService>(create: (_) => SmsQueueService()),
    Provider<PermissionService>(create: (_) => PermissionService()),

    // Repositories.
    Provider<TransactionRepository>(
      create: (BuildContext context) =>
          TransactionRepository(context.read<DatabaseService>()),
    ),
    Provider<CategoryRuleRepository>(
      create: (BuildContext context) =>
          CategoryRuleRepository(context.read<DatabaseService>()),
    ),
    Provider<SenderAllowlistRepository>(
      create: (BuildContext context) =>
          SenderAllowlistRepository(context.read<DatabaseService>()),
    ),
    Provider<SyncStateRepository>(
      create: (BuildContext context) =>
          SyncStateRepository(context.read<DatabaseService>()),
    ),

    // Use cases.
    Provider<CategorizeMerchantUseCase>(
      create: (_) => const CategorizeMerchantUseCase(),
    ),
    Provider<ParseSmsUseCase>(
      create: (BuildContext context) =>
          ParseSmsUseCase(context.read<CategorizeMerchantUseCase>()),
    ),
    Provider<SyncInboxUseCase>(
      create: (BuildContext context) => SyncInboxUseCase(
        inboxService: context.read<SmsInboxService>(),
        queueService: context.read<SmsQueueService>(),
        permissionService: context.read<PermissionService>(),
        allowlistRepository: context.read<SenderAllowlistRepository>(),
        categoryRuleRepository: context.read<CategoryRuleRepository>(),
        syncStateRepository: context.read<SyncStateRepository>(),
        transactionRepository: context.read<TransactionRepository>(),
        parseSms: context.read<ParseSmsUseCase>(),
      ),
    ),

    // ViewModels.
    ChangeNotifierProvider<OverviewViewModel>(
      create: (BuildContext context) => OverviewViewModel(
        transactionRepository: context.read<TransactionRepository>(),
        syncInbox: context.read<SyncInboxUseCase>(),
      ),
    ),
    ChangeNotifierProvider<TransactionsViewModel>(
      create: (BuildContext context) => TransactionsViewModel(
        transactionRepository: context.read<TransactionRepository>(),
      ),
    ),
    ChangeNotifierProvider<SettingsViewModel>(
      create: (BuildContext context) => SettingsViewModel(
        permissionService: context.read<PermissionService>(),
        allowlistRepository: context.read<SenderAllowlistRepository>(),
        categoryRuleRepository: context.read<CategoryRuleRepository>(),
        syncInbox: context.read<SyncInboxUseCase>(),
        parseSms: context.read<ParseSmsUseCase>(),
      ),
    ),
  ];
}
