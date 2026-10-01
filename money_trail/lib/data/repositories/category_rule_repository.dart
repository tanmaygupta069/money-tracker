import 'package:drift/drift.dart';

import '../../domain/models/category_rule.dart';
import '../services/database/app_database.dart';
import '../services/database/database_service.dart';

/// Keyword rules used to categorize merchants.
class CategoryRuleRepository {
  CategoryRuleRepository(this._service);

  final DatabaseService _service;

  Stream<List<CategoryRule>> watchAll() {
    return _service.watchCategoryRules().map(
      (List<CategoryRuleRow> rows) => rows.map(_toDomain).toList(growable: false),
    );
  }

  /// One-shot read for the parser pipeline.
  Future<List<CategoryRule>> getAll() async {
    final List<CategoryRuleRow> rows = await _service.getCategoryRules();
    return rows.map(_toDomain).toList(growable: false);
  }

  Future<void> upsert(CategoryRule rule) {
    return _service.upsertCategoryRule(
      CategoryRulesCompanion(
        id: rule.id == 0 ? const Value<int>.absent() : Value<int>(rule.id),
        keyword: Value<String>(rule.keyword.trim().toLowerCase()),
        category: Value<String>(rule.category),
        priority: Value<int>(rule.priority),
      ),
    );
  }

  Future<void> delete(int id) => _service.deleteCategoryRule(id);

  CategoryRule _toDomain(CategoryRuleRow row) => CategoryRule(
    id: row.id,
    keyword: row.keyword,
    category: row.category,
    priority: row.priority,
  );
}
