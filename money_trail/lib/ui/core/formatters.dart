import '../../domain/models/transaction.dart';

const List<String> _monthNames = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

/// `October 2026`.
String monthLabel(DateTime month) =>
    '${_monthNames[month.month - 1]} ${month.year}';

/// `02 Oct`.
String dayLabel(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')} ${_monthNames[date.month - 1].substring(0, 3)}';

/// `02 Oct 2026, 14:05`.
String dateTimeLabel(DateTime date) {
  final String hour = date.hour.toString().padLeft(2, '0');
  final String minute = date.minute.toString().padLeft(2, '0');
  return '${dayLabel(date)} ${date.year}, $hour:$minute';
}

String sourceLabel(TransactionSource source) => switch (source) {
  TransactionSource.kotak => 'Kotak',
  TransactionSource.slice => 'Slice',
  TransactionSource.gpayManual => 'GPay',
  TransactionSource.cashManual => 'Cash',
};

String categoryLabel(String category) =>
    category.isEmpty ? kUncategorized : category;
