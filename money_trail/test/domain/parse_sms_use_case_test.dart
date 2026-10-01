import 'package:flutter_test/flutter_test.dart';
import 'package:money_trail/data/models/parse_result.dart';
import 'package:money_trail/domain/models/transaction.dart';
import 'package:money_trail/domain/use_cases/categorize_merchant_use_case.dart';
import 'package:money_trail/domain/use_cases/parse_sms_use_case.dart';

import '../fixtures/sample_sms.dart';

void main() {
  const ParseSmsUseCase parse = ParseSmsUseCase(CategorizeMerchantUseCase());

  ParseResult run(SampleSms sms) => parse(
    sender: sms.sender,
    body: sms.body,
    timestampMillis: sms.timestampMillis,
    enabledAllowlistNames: kEnabledSenderNames,
    rules: kSeedRules,
  );

  Transaction parsed(SampleSms sms) {
    final ParseResult result = run(sms);
    expect(result, isA<ParseSuccess>(), reason: 'expected a transaction');
    return (result as ParseSuccess).transaction;
  }

  SkipReason skipped(SampleSms sms) {
    final ParseResult result = run(sms);
    expect(result, isA<ParseSkipped>(), reason: 'expected a skip');
    return (result as ParseSkipped).reason;
  }

  group('Kotak debit', () {
    test('parses a UPI debit with the VM- prefix', () {
      final Transaction transaction = parsed(kotakSwiggyDebit);

      expect(transaction.amountPaise, 25000);
      expect(transaction.type, TransactionType.debit);
      expect(transaction.source, TransactionSource.kotak);
      expect(transaction.merchant?.toLowerCase(), contains('swiggy'));
      expect(transaction.category, 'food');
      expect(transaction.isManual, isFalse);
      expect(transaction.rawSmsBody, kotakSwiggyDebit.body);
      expect(transaction.sender, kotakSwiggyDebit.sender);
      expect(
        transaction.txnTimestamp.millisecondsSinceEpoch,
        kotakSwiggyDebit.timestampMillis,
      );
    });

    test('parses a debit with the AX- prefix and -S suffix', () {
      final Transaction transaction = parsed(kotakAmazonDebit);

      expect(transaction.amountPaise, 119900);
      expect(transaction.source, TransactionSource.kotak);
      expect(transaction.merchant?.toLowerCase(), contains('amazon'));
      expect(transaction.category, 'shopping');
    });

    test('keeps a debit that also carries promo noise', () {
      final Transaction transaction = parsed(kotakDebitWithLink);

      expect(transaction.amountPaise, 32000);
      expect(transaction.category, 'travel');
    });
  });

  group('Slice debit', () {
    test('matches SLICE against SLICEIN', () {
      final Transaction transaction = parsed(sliceZomatoDebit);

      expect(transaction.amountPaise, 45050);
      expect(transaction.source, TransactionSource.slice);
      expect(transaction.merchant?.toLowerCase(), contains('zomato'));
      expect(transaction.category, 'food');
    });
  });

  group('skips', () {
    test('an OTP message', () {
      expect(skipped(kotakOtp), SkipReason.looksLikeOtp);
    });

    test('a promotional message', () {
      expect(skipped(kotakPromo), SkipReason.looksLikePromo);
    });

    test('a credit or refund', () {
      expect(skipped(kotakCredit), SkipReason.creditOrRefund);
    });

    test('a sender that is not on the allowlist', () {
      expect(skipped(unknownSenderDebit), SkipReason.senderNotAllowed);
    });

    test('a message without an amount', () {
      expect(skipped(kotakNoAmount), SkipReason.noAmount);
    });

    test('a balance enquiry, which has an amount but no debit keyword', () {
      expect(skipped(kotakBalanceEnquiry), SkipReason.notDebit);
    });

    test('every message once the allowlist is empty', () {
      final ParseResult result = parse(
        sender: kotakSwiggyDebit.sender,
        body: kotakSwiggyDebit.body,
        timestampMillis: kotakSwiggyDebit.timestampMillis,
        enabledAllowlistNames: const <String>[],
        rules: kSeedRules,
      );

      expect(result, const ParseResult.skipped(SkipReason.senderNotAllowed));
    });
  });

  group('sender normalization', () {
    test('strips carrier prefixes and route suffixes', () {
      expect(ParseSmsUseCase.normalizeSender('VM-KOTAKB'), 'KOTAKB');
      expect(ParseSmsUseCase.normalizeSender('AX-KOTAKB-S'), 'KOTAKB');
      expect(ParseSmsUseCase.normalizeSender('vk-slicein'), 'SLICEIN');
    });
  });

  group('dedup hash', () {
    test('same body and timestamp produce the same hash', () {
      final Transaction first = parsed(kotakSwiggyDebit);
      final Transaction second = parsed(kotakSwiggyDebit);

      expect(first.messageHash, isNotNull);
      expect(first.messageHash, second.messageHash);
      expect(
        first.messageHash,
        ParseSmsUseCase.messageHash(
          kotakSwiggyDebit.body,
          kotakSwiggyDebit.timestampMillis,
        ),
      );
    });

    test('a different timestamp produces a different hash', () {
      final String hash = ParseSmsUseCase.messageHash(kotakSwiggyDebit.body, 1);
      final String other = ParseSmsUseCase.messageHash(
        kotakSwiggyDebit.body,
        2,
      );

      expect(hash, isNot(other));
      expect(hash, matches(RegExp(r'^[0-9a-f]{64}$')));
    });
  });
}
