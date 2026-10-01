// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sender_allowlist_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SenderAllowlistEntry {

 int get id;/// e.g. `KOTAK`, which matches sender IDs such as `VM-KOTAKB`.
 String get name; bool get enabled;
/// Create a copy of SenderAllowlistEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SenderAllowlistEntryCopyWith<SenderAllowlistEntry> get copyWith => _$SenderAllowlistEntryCopyWithImpl<SenderAllowlistEntry>(this as SenderAllowlistEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SenderAllowlistEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SenderAllowlistEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled));
}


@override
int get hashCode {
  final _this = this as SenderAllowlistEntry;
  return Object.hash(runtimeType,_this.id,_this.name,_this.enabled);
}

@override
String toString() {
  final _this = this as SenderAllowlistEntry;
  return 'SenderAllowlistEntry(id: ${_this.id}, name: ${_this.name}, enabled: ${_this.enabled})';
}


}

/// @nodoc
abstract mixin class $SenderAllowlistEntryCopyWith<$Res>  {
  factory $SenderAllowlistEntryCopyWith(SenderAllowlistEntry value, $Res Function(SenderAllowlistEntry) _then) = _$SenderAllowlistEntryCopyWithImpl;
@useResult
$Res call({
 int id, String name, bool enabled
});




}
/// @nodoc
class _$SenderAllowlistEntryCopyWithImpl<$Res>
    implements $SenderAllowlistEntryCopyWith<$Res> {
  _$SenderAllowlistEntryCopyWithImpl(this._self, this._then);

  final SenderAllowlistEntry _self;
  final $Res Function(SenderAllowlistEntry) _then;

/// Create a copy of SenderAllowlistEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? enabled = null,}) {
  return _then(SenderAllowlistEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SenderAllowlistEntry].
extension SenderAllowlistEntryPatterns on SenderAllowlistEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SenderAllowlistEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SenderAllowlistEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SenderAllowlistEntry value)  $default,){
final _that = this;
switch (_that) {
case _SenderAllowlistEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SenderAllowlistEntry value)?  $default,){
final _that = this;
switch (_that) {
case _SenderAllowlistEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SenderAllowlistEntry() when $default != null:
return $default(_that.id,_that.name,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _SenderAllowlistEntry():
return $default(_that.id,_that.name,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _SenderAllowlistEntry() when $default != null:
return $default(_that.id,_that.name,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc


class _SenderAllowlistEntry implements SenderAllowlistEntry {
  const _SenderAllowlistEntry({this.id = 0, required this.name, this.enabled = true});
  

@override@JsonKey() final  int id;
/// e.g. `KOTAK`, which matches sender IDs such as `VM-KOTAKB`.
@override final  String name;
@override@JsonKey() final  bool enabled;

/// Create a copy of SenderAllowlistEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SenderAllowlistEntryCopyWith<_SenderAllowlistEntry> get copyWith => __$SenderAllowlistEntryCopyWithImpl<_SenderAllowlistEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SenderAllowlistEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,enabled);
}

@override
String toString() {
    return 'SenderAllowlistEntry(id: $id, name: $name, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$SenderAllowlistEntryCopyWith<$Res> implements $SenderAllowlistEntryCopyWith<$Res> {
  factory _$SenderAllowlistEntryCopyWith(_SenderAllowlistEntry value, $Res Function(_SenderAllowlistEntry) _then) = __$SenderAllowlistEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, bool enabled
});




}
/// @nodoc
class __$SenderAllowlistEntryCopyWithImpl<$Res>
    implements _$SenderAllowlistEntryCopyWith<$Res> {
  __$SenderAllowlistEntryCopyWithImpl(this._self, this._then);

  final _SenderAllowlistEntry _self;
  final $Res Function(_SenderAllowlistEntry) _then;

/// Create a copy of SenderAllowlistEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? enabled = null,}) {
  return _then(_SenderAllowlistEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
