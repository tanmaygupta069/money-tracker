import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_rule.freezed.dart';

/// Maps a keyword found in a merchant name (or the raw SMS) to a category.
@freezed
abstract class CategoryRule with _$CategoryRule {
  const factory CategoryRule({
    @Default(0) int id,

    /// Always lowercase so matching never has to care about case.
    required String keyword,
    required String category,

    /// Higher wins when several rules match the same merchant.
    @Default(0) int priority,
  }) = _CategoryRule;
}
