import 'package:flutter/material.dart';

import '../../../domain/models/money.dart';

/// Renders paise as rupees. Every amount on screen goes through this.
class MoneyText extends StatelessWidget {
  const MoneyText(this.paise, {super.key, this.style});

  final int paise;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      Money.paiseToRupeeLabel(paise),
      style: style ?? Theme.of(context).textTheme.bodyLarge,
    );
  }
}
