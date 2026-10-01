import 'package:flutter/material.dart';

import 'app.dart';
import 'data/services/database/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppDatabase database = AppDatabase();
  // Forces the connection open so the first-run migration and seed finish
  // before the first frame.
  await database.customSelect('SELECT 1').getSingle();

  runApp(MoneyTrailApp(database: database));
}
