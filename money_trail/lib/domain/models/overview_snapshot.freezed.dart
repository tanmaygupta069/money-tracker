// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'overview_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OverviewSnapshot {

/// First instant of the month this snapshot covers.
 DateTime get month; int get totalPaise; Map<TransactionSource, int> get bySource;/// Sorted by total, descending.
 List<CategoryTotal> get byCategory;/// Top ten by total, descending.
 List<MerchantTotal> get topMerchants;
/// Create a copy of OverviewSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverviewSnapshotCopyWith<OverviewSnapshot> get copyWith => _$OverviewSnapshotCopyWithImpl<OverviewSnapshot>(this as OverviewSnapshot, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OverviewSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OverviewSnapshot&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.totalPaise, _this.totalPaise) || other.totalPaise == _this.totalPaise)&&const DeepCollectionEquality().equals(other.bySource, _this.bySource)&&const DeepCollectionEquality().equals(other.byCategory, _this.byCategory)&&const DeepCollectionEquality().equals(other.topMerchants, _this.topMerchants));
}


@override
int get hashCode {
  final _this = this as OverviewSnapshot;
  return Object.hash(runtimeType,_this.month,_this.totalPaise,const DeepCollectionEquality().hash(_this.bySource),const DeepCollectionEquality().hash(_this.byCategory),const DeepCollectionEquality().hash(_this.topMerchants));
}

@override
String toString() {
  final _this = this as OverviewSnapshot;
  return 'OverviewSnapshot(month: ${_this.month}, totalPaise: ${_this.totalPaise}, bySource: ${_this.bySource}, byCategory: ${_this.byCategory}, topMerchants: ${_this.topMerchants})';
}


}

/// @nodoc
abstract mixin class $OverviewSnapshotCopyWith<$Res>  {
  factory $OverviewSnapshotCopyWith(OverviewSnapshot value, $Res Function(OverviewSnapshot) _then) = _$OverviewSnapshotCopyWithImpl;
@useResult
$Res call({
 DateTime month, int totalPaise, Map<TransactionSource, int> bySource, List<CategoryTotal> byCategory, List<MerchantTotal> topMerchants
});




}
/// @nodoc
class _$OverviewSnapshotCopyWithImpl<$Res>
    implements $OverviewSnapshotCopyWith<$Res> {
  _$OverviewSnapshotCopyWithImpl(this._self, this._then);

  final OverviewSnapshot _self;
  final $Res Function(OverviewSnapshot) _then;

/// Create a copy of OverviewSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? totalPaise = null,Object? bySource = null,Object? byCategory = null,Object? topMerchants = null,}) {
  return _then(OverviewSnapshot(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,totalPaise: null == totalPaise ? _self.totalPaise : totalPaise // ignore: cast_nullable_to_non_nullable
as int,bySource: null == bySource ? _self.bySource : bySource // ignore: cast_nullable_to_non_nullable
as Map<TransactionSource, int>,byCategory: null == byCategory ? _self.byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<CategoryTotal>,topMerchants: null == topMerchants ? _self.topMerchants : topMerchants // ignore: cast_nullable_to_non_nullable
as List<MerchantTotal>,
  ));
}

}


/// Adds pattern-matching-related methods to [OverviewSnapshot].
extension OverviewSnapshotPatterns on OverviewSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OverviewSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OverviewSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OverviewSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _OverviewSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OverviewSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _OverviewSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime month,  int totalPaise,  Map<TransactionSource, int> bySource,  List<CategoryTotal> byCategory,  List<MerchantTotal> topMerchants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OverviewSnapshot() when $default != null:
return $default(_that.month,_that.totalPaise,_that.bySource,_that.byCategory,_that.topMerchants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime month,  int totalPaise,  Map<TransactionSource, int> bySource,  List<CategoryTotal> byCategory,  List<MerchantTotal> topMerchants)  $default,) {final _that = this;
switch (_that) {
case _OverviewSnapshot():
return $default(_that.month,_that.totalPaise,_that.bySource,_that.byCategory,_that.topMerchants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime month,  int totalPaise,  Map<TransactionSource, int> bySource,  List<CategoryTotal> byCategory,  List<MerchantTotal> topMerchants)?  $default,) {final _that = this;
switch (_that) {
case _OverviewSnapshot() when $default != null:
return $default(_that.month,_that.totalPaise,_that.bySource,_that.byCategory,_that.topMerchants);case _:
  return null;

}
}

}

/// @nodoc


class _OverviewSnapshot implements OverviewSnapshot {
  const _OverviewSnapshot({required this.month, required this.totalPaise, required  Map<TransactionSource, int> bySource, required  List<CategoryTotal> byCategory, required  List<MerchantTotal> topMerchants}): _bySource = bySource,_byCategory = byCategory,_topMerchants = topMerchants;
  

/// First instant of the month this snapshot covers.
@override final  DateTime month;
@override final  int totalPaise;
 final  Map<TransactionSource, int> _bySource;
@override Map<TransactionSource, int> get bySource {
  if (_bySource is EqualUnmodifiableMapView) return _bySource;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_bySource);
}

/// Sorted by total, descending.
 final  List<CategoryTotal> _byCategory;
/// Sorted by total, descending.
@override List<CategoryTotal> get byCategory {
  if (_byCategory is EqualUnmodifiableListView) return _byCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byCategory);
}

/// Top ten by total, descending.
 final  List<MerchantTotal> _topMerchants;
/// Top ten by total, descending.
@override List<MerchantTotal> get topMerchants {
  if (_topMerchants is EqualUnmodifiableListView) return _topMerchants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topMerchants);
}


/// Create a copy of OverviewSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverviewSnapshotCopyWith<_OverviewSnapshot> get copyWith => __$OverviewSnapshotCopyWithImpl<_OverviewSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverviewSnapshot&&(identical(other.month, month) || other.month == month)&&(identical(other.totalPaise, totalPaise) || other.totalPaise == totalPaise)&&const DeepCollectionEquality().equals(other.bySource, _bySource)&&const DeepCollectionEquality().equals(other.byCategory, _byCategory)&&const DeepCollectionEquality().equals(other.topMerchants, _topMerchants));
}


@override
int get hashCode {
    return Object.hash(runtimeType,month,totalPaise,const DeepCollectionEquality().hash(_bySource),const DeepCollectionEquality().hash(_byCategory),const DeepCollectionEquality().hash(_topMerchants));
}

@override
String toString() {
    return 'OverviewSnapshot(month: $month, totalPaise: $totalPaise, bySource: $bySource, byCategory: $byCategory, topMerchants: $topMerchants)';
}


}

/// @nodoc
abstract mixin class _$OverviewSnapshotCopyWith<$Res> implements $OverviewSnapshotCopyWith<$Res> {
  factory _$OverviewSnapshotCopyWith(_OverviewSnapshot value, $Res Function(_OverviewSnapshot) _then) = __$OverviewSnapshotCopyWithImpl;
@override @useResult
$Res call({
 DateTime month, int totalPaise, Map<TransactionSource, int> bySource, List<CategoryTotal> byCategory, List<MerchantTotal> topMerchants
});




}
/// @nodoc
class __$OverviewSnapshotCopyWithImpl<$Res>
    implements _$OverviewSnapshotCopyWith<$Res> {
  __$OverviewSnapshotCopyWithImpl(this._self, this._then);

  final _OverviewSnapshot _self;
  final $Res Function(_OverviewSnapshot) _then;

/// Create a copy of OverviewSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? totalPaise = null,Object? bySource = null,Object? byCategory = null,Object? topMerchants = null,}) {
  return _then(_OverviewSnapshot(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,totalPaise: null == totalPaise ? _self.totalPaise : totalPaise // ignore: cast_nullable_to_non_nullable
as int,bySource: null == bySource ? _self._bySource : bySource // ignore: cast_nullable_to_non_nullable
as Map<TransactionSource, int>,byCategory: null == byCategory ? _self._byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<CategoryTotal>,topMerchants: null == topMerchants ? _self._topMerchants : topMerchants // ignore: cast_nullable_to_non_nullable
as List<MerchantTotal>,
  ));
}


}

// dart format on
