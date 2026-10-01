import 'package:flutter_test/flutter_test.dart';
import 'package:money_trail/domain/models/category_rule.dart';
import 'package:money_trail/domain/models/transaction.dart';
import 'package:money_trail/domain/use_cases/categorize_merchant_use_case.dart';

import '../fixtures/sample_sms.dart';

void main() {
  const CategorizeMerchantUseCase categorize = CategorizeMerchantUseCase();

  test('matches a keyword inside the merchant, ignoring case', () {
    expect(
      categorize(merchant: 'SWIGGY', body: 'irrelevant', rules: kSeedRules),
      'food',
    );
  });

  test('falls back to the body when there is no merchant', () {
    expect(
      categorize(
        merchant: null,
        body: 'Rs.900.00 paid for ELECTRICITY bill',
        rules: kSeedRules,
      ),
      'bills',
    );
  });

  test('treats a blank merchant like a missing one', () {
    expect(
      categorize(merchant: '   ', body: 'UBER ride', rules: kSeedRules),
      'travel',
    );
  });

  test('highest priority wins when several rules match', () {
    const List<CategoryRule> rules = <CategoryRule>[
      CategoryRule(keyword: 'swiggy', category: 'shopping', priority: 1),
      CategoryRule(keyword: 'swiggy instamart', category: 'food', priority: 10),
    ];

    expect(
      categorize(merchant: 'Swiggy Instamart', body: '', rules: rules),
      'food',
    );
  });

  test('defaults to uncategorized when nothing matches', () {
    expect(
      categorize(
        merchant: 'SOME LOCAL SHOP',
        body: 'no keywords here',
        rules: kSeedRules,
      ),
      kUncategorized,
    );
  });

  test('defaults to uncategorized when there are no rules', () {
    expect(
      categorize(
        merchant: 'SWIGGY',
        body: 'irrelevant',
        rules: const <CategoryRule>[],
      ),
      kUncategorized,
    );
  });
}
