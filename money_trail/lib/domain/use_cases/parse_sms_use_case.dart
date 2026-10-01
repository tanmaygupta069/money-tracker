import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../data/models/parse_result.dart';
import '../models/category_rule.dart';
import '../models/money.dart';
import '../models/transaction.dart';
import 'categorize_merchant_use_case.dart';

/// Turns one raw SMS into a debit [Transaction], or explains why it was
/// skipped. This is the only place in the app that knows the SMS formats; the
/// native layer never parses.
///
/// Shared by inbox sync, the native queue drain and the Settings tester.
class ParseSmsUseCase {
  const ParseSmsUseCase(this._categorize);

  final CategorizeMerchantUseCase _categorize;

  /// Carrier prefixes seen on Indian sender IDs, e.g. `VM-KOTAKB`.
  static final RegExp _carrierPrefix = RegExp(
    r'^(?:VM|AX|AD|JK|JD|BX|CP|VK|TM)-',
  );

  /// Trailing route marker, e.g. the `-S` in `AX-KOTAKB-S`.
  static final RegExp _trailingRouteSuffix = RegExp(r'-[A-Z]$');

  static final RegExp _amountPattern = RegExp(
    r'(?:\b(?:rs|inr)\b\.?\s*|₹\s*)'
    r'(\d{1,3}(?:,\d{2,3})*(?:\.\d{1,2})?|\d+(?:\.\d{1,2})?)',
    caseSensitive: false,
  );

  static final RegExp _debitKeywords = RegExp(
    r'\b(?:debited|spent|sent|paid|purchase\w*|withdrawn)\b',
    caseSensitive: false,
  );

  static final RegExp _creditKeywords = RegExp(
    r'\b(?:credited|refund\w*|received|deposited)\b',
    caseSensitive: false,
  );

  static final RegExp _otpPattern = RegExp(
    r'\botp\b|one[\s-]?time\s+password|verification\s+code',
    caseSensitive: false,
  );

  static final RegExp _promoPattern = RegExp(
    r'\boffers?\b|limited\s+time|click\s+here|https?://',
    caseSensitive: false,
  );

  /// Stop words that end a merchant name, e.g. `to SWIGGY on 01-10-26`.
  static const String _merchantStop =
      r'(?=\s+(?:on|for|from|ref|upi|using|via|dated|a/c|ac|acct)\b|[.,;:!?\n]|$)';

  static final RegExp _merchantToPattern = RegExp(
    r'\bto\s+(.+?)' + _merchantStop,
    caseSensitive: false,
  );

  static final RegExp _merchantAtPattern = RegExp(
    r'\bat\s+(.+?)' + _merchantStop,
    caseSensitive: false,
  );

  static final RegExp _vpaPattern = RegExp(r'[\w.\-]+@[\w]+');

  static final RegExp _infoPattern = RegExp(
    r'\binfo\s*:\s*(.+)',
    caseSensitive: false,
  );

  ParseResult call({
    required String sender,
    required String body,
    required int timestampMillis,
    required List<String> enabledAllowlistNames,
    required List<CategoryRule> rules,
  }) {
    // 1 + 2. Trusted sender, matched after the carrier prefix is stripped.
    final String normalizedSender = normalizeSender(sender);
    final List<String> matchedNames = _matchedAllowlistNames(
      normalizedSender,
      enabledAllowlistNames,
    );
    if (matchedNames.isEmpty) {
      return const ParseResult.skipped(SkipReason.senderNotAllowed);
    }

    // 3. OTP and promo noise. A message that carries both a debit keyword and
    // an amount is treated as a real debit even if it also looks promotional.
    final bool hasDebitKeyword = _debitKeywords.hasMatch(body);
    final int? amountPaise = _extractAmountPaise(body);
    final bool looksTransactional = hasDebitKeyword && amountPaise != null;

    if (!looksTransactional && _otpPattern.hasMatch(body)) {
      return const ParseResult.skipped(SkipReason.looksLikeOtp);
    }
    if (!looksTransactional && _promoPattern.hasMatch(body)) {
      return const ParseResult.skipped(SkipReason.looksLikePromo);
    }

    // 4. Amount.
    if (amountPaise == null) {
      return const ParseResult.skipped(SkipReason.noAmount);
    }

    // 5. Debit versus credit. Credits and refunds are not stored in v0.
    if (_creditKeywords.hasMatch(body)) {
      return const ParseResult.skipped(SkipReason.creditOrRefund);
    }
    if (!hasDebitKeyword) {
      return const ParseResult.skipped(SkipReason.notDebit);
    }

    // 6. Merchant.
    final String? merchant = _extractMerchant(body);

    // 7. Source. An allowlist name that maps to neither bank cannot become a
    // transaction, because v0 only models Kotak, Slice and manual entries.
    final TransactionSource? source = _sourceFor(matchedNames);
    if (source == null) {
      return const ParseResult.skipped(SkipReason.unparseable);
    }

    // 8 + 9 + 10.
    return ParseResult.success(
      Transaction(
        amountPaise: amountPaise,
        type: TransactionType.debit,
        source: source,
        merchant: merchant,
        category: _categorize(merchant: merchant, body: body, rules: rules),
        txnTimestamp: DateTime.fromMillisecondsSinceEpoch(timestampMillis),
        isManual: false,
        rawSmsBody: body,
        sender: sender,
        messageHash: messageHash(body, timestampMillis),
        createdAt: DateTime.now(),
      ),
    );
  }

  /// Uppercases and drops the carrier prefix and route suffix, so both
  /// `VM-KOTAKB` and `AX-KOTAKB-S` still contain `KOTAK`.
  static String normalizeSender(String sender) {
    return sender
        .toUpperCase()
        .trim()
        .replaceFirst(_carrierPrefix, '')
        .replaceFirst(_trailingRouteSuffix, '');
  }

  /// `sha256(body + timestampMillis)` as lowercase hex. Live capture and inbox
  /// sync produce the same hash for the same message, which is what the unique
  /// index relies on.
  static String messageHash(String body, int timestampMillis) {
    return sha256.convert(utf8.encode('$body$timestampMillis')).toString();
  }

  /// Enabled names contained in the normalized sender, longest first.
  List<String> _matchedAllowlistNames(
    String normalizedSender,
    List<String> enabledAllowlistNames,
  ) {
    final List<String> matches = enabledAllowlistNames
        .map((String name) => name.trim().toUpperCase())
        .where(
          (String name) => name.isNotEmpty && normalizedSender.contains(name),
        )
        .toList();
    matches.sort((String a, String b) => b.length.compareTo(a.length));
    return matches;
  }

  int? _extractAmountPaise(String body) {
    final RegExpMatch? match = _amountPattern.firstMatch(body);
    if (match == null) return null;
    return Money.rupeesToPaise(match.group(1)!);
  }

  String? _extractMerchant(String body) {
    for (final RegExp pattern in <RegExp>[
      _merchantToPattern,
      _merchantAtPattern,
    ]) {
      final String? merchant = _cleanMerchant(
        pattern.firstMatch(body)?.group(1),
      );
      if (merchant != null) return merchant;
    }

    final String? vpa = _cleanMerchant(_vpaPattern.firstMatch(body)?.group(0));
    if (vpa != null) return vpa;

    return _cleanMerchant(_infoPattern.firstMatch(body)?.group(1));
  }

  String? _cleanMerchant(String? raw) {
    if (raw == null) return null;
    final String collapsed = raw.split('\n').first.replaceAll(
      RegExp(r'\s+'),
      ' ',
    );
    final String trimmed = collapsed
        .trim()
        .replaceAll(RegExp(r'^[^\w@]+'), '')
        .replaceAll(RegExp(r'[^\w@]+$'), '');
    return trimmed.isEmpty ? null : trimmed;
  }

  TransactionSource? _sourceFor(List<String> matchedNames) {
    for (final String name in matchedNames) {
      if (name.contains('KOTAK')) return TransactionSource.kotak;
      if (name.contains('SLICE')) return TransactionSource.slice;
    }
    return null;
  }
}
