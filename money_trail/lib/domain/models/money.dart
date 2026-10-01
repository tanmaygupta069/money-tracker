/// Money handling for MoneyTrail.
///
/// Every amount in the app is an integer number of paise. Rupee values only
/// exist at the edges: text the user types in, and labels shown on screen.
class Money {
  const Money._();

  /// Parses a user- or SMS-supplied rupee amount into paise.
  ///
  /// Accepts grouping commas and up to two decimals; anything beyond two
  /// decimals is rounded to the nearest paise. Returns null when [raw] is not
  /// a number.
  static int? rupeesToPaise(String raw) {
    final cleaned = raw.replaceAll(',', '').replaceAll(RegExp(r'\s'), '');
    final match = RegExp(r'^(\d*)(?:\.(\d+))?$').firstMatch(cleaned);
    if (match == null) return null;

    final whole = match.group(1) ?? '';
    final fraction = match.group(2) ?? '';
    if (whole.isEmpty && fraction.isEmpty) return null;

    final rupees = whole.isEmpty ? 0 : int.tryParse(whole);
    if (rupees == null) return null;

    var paise = rupees * 100;
    if (fraction.isNotEmpty) {
      final twoDigits = fraction.length >= 2
          ? fraction.substring(0, 2)
          : fraction.padRight(2, '0');
      paise += int.parse(twoDigits);
      if (fraction.length > 2 && int.parse(fraction[2]) >= 5) paise += 1;
    }
    return paise;
  }

  /// Formats paise for display, e.g. `123450` becomes `₹1,234.50`.
  static String paiseToRupeeLabel(int paise) {
    final sign = paise < 0 ? '-' : '';
    final absolute = paise.abs();
    final fraction = (absolute % 100).toString().padLeft(2, '0');
    return '$sign₹${_groupIndian(absolute ~/ 100)}.$fraction';
  }

  /// Indian digit grouping: three digits, then pairs (`1,23,456`).
  static String _groupIndian(int rupees) {
    final digits = rupees.toString();
    if (digits.length <= 3) return digits;

    final last3 = digits.substring(digits.length - 3);
    var rest = digits.substring(0, digits.length - 3);
    final groups = <String>[];
    while (rest.length > 2) {
      groups.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) groups.insert(0, rest);
    return '${groups.join(',')},$last3';
  }
}
