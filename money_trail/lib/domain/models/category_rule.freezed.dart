// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryRule {

 int get id;/// Always lowercase so matching never has to care about case.
 String get keyword; String get category;/// Higher wins when several rules match the same merchant.
 int get priority;
/// Create a copy of CategoryRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryRuleCopyWith<CategoryRule> get copyWith => _$CategoryRuleCopyWithImpl<CategoryRule>(this as CategoryRule, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryRule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryRule&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.keyword, _this.keyword) || other.keyword == _this.keyword)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.priority, _this.priority) || other.priority == _this.priority));
}


@override
int get hashCode {
  final _this = this as CategoryRule;
  return Object.hash(runtimeType,_this.id,_this.keyword,_this.category,_this.priority);
}

@override
String toString() {
  final _this = this as CategoryRule;
  return 'CategoryRule(id: ${_this.id}, keyword: ${_this.keyword}, category: ${_this.category}, priority: ${_this.priority})';
}


}

/// @nodoc
abstract mixin class $CategoryRuleCopyWith<$Res>  {
  factory $CategoryRuleCopyWith(CategoryRule value, $Res Function(CategoryRule) _then) = _$CategoryRuleCopyWithImpl;
@useResult
$Res call({
 int id, String keyword, String category, int priority
});




}
/// @nodoc
class _$CategoryRuleCopyWithImpl<$Res>
    implements $CategoryRuleCopyWith<$Res> {
  _$CategoryRuleCopyWithImpl(this._self, this._then);

  final CategoryRule _self;
  final $Res Function(CategoryRule) _then;

/// Create a copy of CategoryRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? keyword = null,Object? category = null,Object? priority = null,}) {
  return _then(CategoryRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryRule].
extension CategoryRulePatterns on CategoryRule {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryRule() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryRule value)  $default,){
final _that = this;
switch (_that) {
case _CategoryRule():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryRule value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryRule() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String keyword,  String category,  int priority)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryRule() when $default != null:
return $default(_that.id,_that.keyword,_that.category,_that.priority);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String keyword,  String category,  int priority)  $default,) {final _that = this;
switch (_that) {
case _CategoryRule():
return $default(_that.id,_that.keyword,_that.category,_that.priority);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String keyword,  String category,  int priority)?  $default,) {final _that = this;
switch (_that) {
case _CategoryRule() when $default != null:
return $default(_that.id,_that.keyword,_that.category,_that.priority);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryRule implements CategoryRule {
  const _CategoryRule({this.id = 0, required this.keyword, required this.category, this.priority = 0});
  

@override@JsonKey() final  int id;
/// Always lowercase so matching never has to care about case.
@override final  String keyword;
@override final  String category;
/// Higher wins when several rules match the same merchant.
@override@JsonKey() final  int priority;

/// Create a copy of CategoryRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryRuleCopyWith<_CategoryRule> get copyWith => __$CategoryRuleCopyWithImpl<_CategoryRule>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryRule&&(identical(other.id, id) || other.id == id)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.category, category) || other.category == category)&&(identical(other.priority, priority) || other.priority == priority));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,keyword,category,priority);
}

@override
String toString() {
    return 'CategoryRule(id: $id, keyword: $keyword, category: $category, priority: $priority)';
}


}

/// @nodoc
abstract mixin class _$CategoryRuleCopyWith<$Res> implements $CategoryRuleCopyWith<$Res> {
  factory _$CategoryRuleCopyWith(_CategoryRule value, $Res Function(_CategoryRule) _then) = __$CategoryRuleCopyWithImpl;
@override @useResult
$Res call({
 int id, String keyword, String category, int priority
});




}
/// @nodoc
class __$CategoryRuleCopyWithImpl<$Res>
    implements _$CategoryRuleCopyWith<$Res> {
  __$CategoryRuleCopyWithImpl(this._self, this._then);

  final _CategoryRule _self;
  final $Res Function(_CategoryRule) _then;

/// Create a copy of CategoryRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? keyword = null,Object? category = null,Object? priority = null,}) {
  return _then(_CategoryRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
