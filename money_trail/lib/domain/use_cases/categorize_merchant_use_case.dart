import '../models/category_rule.dart';
import '../models/transaction.dart';

/// Maps a merchant to a category using the seeded keyword rules.
///
/// Matching is substring based and case insensitive. When several rules match,
/// the highest priority wins; ties keep the first rule seen.
class CategorizeMerchantUseCase {
  const CategorizeMerchantUseCase();

  String call({
    required String? merchant,
    required String body,
    required List<CategoryRule> rules,
  }) {
    // Falls back to the raw message when no merchant could be extracted.
    final String haystack =
        (merchant == null || merchant.trim().isEmpty ? body : merchant)
            .toLowerCase();

    CategoryRule? best;
    for (final CategoryRule rule in rules) {
      final String keyword = rule.keyword.trim().toLowerCase();
      if (keyword.isEmpty || !haystack.contains(keyword)) continue;
      if (best == null || rule.priority > best.priority) best = rule;
    }
    return best?.category ?? kUncategorized;
  }
}
