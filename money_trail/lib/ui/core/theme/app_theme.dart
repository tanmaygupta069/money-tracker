import 'package:flutter/material.dart';

/// Material 3 theme for MoneyTrail: a deep ledger green rather than the
/// template purple.
class AppTheme {
  const AppTheme._();

  static const Color _seed = Color(0xFF0F5C4A);

  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      cardTheme: const CardThemeData(elevation: 0),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
