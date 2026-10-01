import 'package:money_trail/domain/models/category_rule.dart';

/// Synthetic but realistic bank SMS used by the parser tests.
class SampleSms {
  const SampleSms({
    required this.sender,
    required this.body,
    required this.timestampMillis,
  });

  final String sender;
  final String body;
  final int timestampMillis;
}

/// Kotak UPI debit, carrier prefix `VM-`.
const SampleSms kotakSwiggyDebit = SampleSms(
  sender: 'VM-KOTAKB',
  body:
      'Dear Customer, Rs.250.00 has been debited from your a/c XX1234 to '
      'SWIGGY on 01-10-26. UPI: swiggy@okaxis. Not you? Call 18602662666',
  timestampMillis: 1727770000000,
);

/// Kotak debit with the `AX-` prefix and a `-S` route suffix.
const SampleSms kotakAmazonDebit = SampleSms(
  sender: 'AX-KOTAKB-S',
  body:
      'INR 1,199.00 debited from Kotak a/c XX9876 at AMAZON on 30-09-26. '
      'Info: UPI',
  timestampMillis: 1727683600000,
);

/// Slice card debit; the allowlist name `SLICE` has to match `SLICEIN`.
const SampleSms sliceZomatoDebit = SampleSms(
  sender: 'VK-SLICEIN',
  body: 'Spent Rs 450.50 at Zomato on your Slice card ending 1234.',
  timestampMillis: 1727600000000,
);

const SampleSms kotakOtp = SampleSms(
  sender: 'VM-KOTAKB',
  body: '482193 is your OTP for login. Do not share.',
  timestampMillis: 1727770500000,
);

const SampleSms kotakCredit = SampleSms(
  sender: 'VM-KOTAKB',
  body: 'Rs.100.00 credited to your a/c XX1234 from REFUND.',
  timestampMillis: 1727771000000,
);

const SampleSms unknownSenderDebit = SampleSms(
  sender: 'VM-PROMOJ',
  body: 'Rs.50.00 debited to FOO',
  timestampMillis: 1727772000000,
);

const SampleSms kotakPromo = SampleSms(
  sender: 'VM-KOTAKB',
  body:
      'Exciting offer on personal loans! Limited time only. Click here '
      'https://example.invalid/loans',
  timestampMillis: 1727773000000,
);

/// A debit that also carries promo noise; the debit must still win.
const SampleSms kotakDebitWithLink = SampleSms(
  sender: 'VM-KOTAKB',
  body:
      'Rs.320.00 debited from a/c XX1234 to UBER on 02-10-26. Offer: see '
      'https://example.invalid/rewards',
  timestampMillis: 1727774000000,
);

const SampleSms kotakBalanceEnquiry = SampleSms(
  sender: 'VM-KOTAKB',
  body: 'Available balance in your a/c XX1234 is Rs.5,400.25 as on 02-10-26.',
  timestampMillis: 1727775000000,
);

const SampleSms kotakNoAmount = SampleSms(
  sender: 'VM-KOTAKB',
  body: 'Your monthly a/c statement for XX1234 is ready.',
  timestampMillis: 1727776000000,
);

const List<String> kEnabledSenderNames = <String>['KOTAK', 'SLICE'];

/// Mirrors the rules seeded into `category_rules` on first open.
const List<CategoryRule> kSeedRules = <CategoryRule>[
  CategoryRule(id: 1, keyword: 'swiggy', category: 'food', priority: 10),
  CategoryRule(id: 2, keyword: 'zomato', category: 'food', priority: 10),
  CategoryRule(id: 3, keyword: 'uber', category: 'travel', priority: 10),
  CategoryRule(id: 4, keyword: 'ola', category: 'travel', priority: 10),
  CategoryRule(id: 5, keyword: 'electricity', category: 'bills', priority: 10),
  CategoryRule(id: 6, keyword: 'jio', category: 'bills', priority: 5),
  CategoryRule(id: 7, keyword: 'amazon', category: 'shopping', priority: 5),
  CategoryRule(id: 8, keyword: 'flipkart', category: 'shopping', priority: 5),
];
