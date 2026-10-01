import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/services/database/app_database.dart';
import 'di.dart';
import 'ui/core/theme/app_theme.dart';
import 'ui/features/overview/view_models/overview_view_model.dart';
import 'ui/features/overview/views/overview_view.dart';
import 'ui/features/settings/view_models/settings_view_model.dart';
import 'ui/features/settings/views/settings_view.dart';
import 'ui/features/transactions/views/transactions_view.dart';

class MoneyTrailApp extends StatelessWidget {
  const MoneyTrailApp({required this.database, super.key});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders(database),
      child: MaterialApp(
        title: 'MoneyTrail',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const HomeShell(),
      ),
    );
  }
}

/// Overview, Transactions and Settings behind a NavigationBar.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> with WidgetsBindingObserver {
  static const List<String> _titles = <String>[
    'Overview',
    'Transactions',
    'Settings',
  ];

  int _index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _catchUp();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _catchUp();
  }

  /// Fire and forget: the ViewModels are watching the database, so whatever
  /// this stores shows up on its own.
  void _catchUp() {
    context.read<OverviewViewModel>().syncFromInbox();
    context.read<SettingsViewModel>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index])),
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: const <Widget>[
            OverviewView(),
            TransactionsView(),
            SettingsView(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (int index) => setState(() => _index = index),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.pie_chart_outline),
            selectedIcon: Icon(Icons.pie_chart),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
