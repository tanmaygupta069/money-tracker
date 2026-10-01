import 'package:flutter/material.dart';

/// A plain proportion bar, drawn with layout widgets rather than a chart
/// package.
class ShareBar extends StatelessWidget {
  const ShareBar({required this.fraction, super.key, this.color});

  /// Clamped to 0..1.
  final double fraction;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 8,
        color: scheme.surfaceContainerHighest,
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: fraction.isFinite ? fraction.clamp(0.0, 1.0) : 0.0,
          child: Container(color: color ?? scheme.primary),
        ),
      ),
    );
  }
}
