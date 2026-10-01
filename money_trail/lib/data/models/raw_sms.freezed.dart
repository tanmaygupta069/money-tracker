// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'raw_sms.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RawSms {

 String get sender; String get body; int get timestampMillis;
/// Create a copy of RawSms
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RawSmsCopyWith<RawSms> get copyWith => _$RawSmsCopyWithImpl<RawSms>(this as RawSms, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RawSms;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawSms&&(identical(other.sender, _this.sender) || other.sender == _this.sender)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.timestampMillis, _this.timestampMillis) || other.timestampMillis == _this.timestampMillis));
}


@override
int get hashCode {
  final _this = this as RawSms;
  return Object.hash(runtimeType,_this.sender,_this.body,_this.timestampMillis);
}

@override
String toString() {
  final _this = this as RawSms;
  return 'RawSms(sender: ${_this.sender}, body: ${_this.body}, timestampMillis: ${_this.timestampMillis})';
}


}

/// @nodoc
abstract mixin class $RawSmsCopyWith<$Res>  {
  factory $RawSmsCopyWith(RawSms value, $Res Function(RawSms) _then) = _$RawSmsCopyWithImpl;
@useResult
$Res call({
 String sender, String body, int timestampMillis
});




}
/// @nodoc
class _$RawSmsCopyWithImpl<$Res>
    implements $RawSmsCopyWith<$Res> {
  _$RawSmsCopyWithImpl(this._self, this._then);

  final RawSms _self;
  final $Res Function(RawSms) _then;

/// Create a copy of RawSms
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sender = null,Object? body = null,Object? timestampMillis = null,}) {
  return _then(RawSms(
sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,timestampMillis: null == timestampMillis ? _self.timestampMillis : timestampMillis // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RawSms].
extension RawSmsPatterns on RawSms {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RawSms value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RawSms() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RawSms value)  $default,){
final _that = this;
switch (_that) {
case _RawSms():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RawSms value)?  $default,){
final _that = this;
switch (_that) {
case _RawSms() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sender,  String body,  int timestampMillis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RawSms() when $default != null:
return $default(_that.sender,_that.body,_that.timestampMillis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sender,  String body,  int timestampMillis)  $default,) {final _that = this;
switch (_that) {
case _RawSms():
return $default(_that.sender,_that.body,_that.timestampMillis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sender,  String body,  int timestampMillis)?  $default,) {final _that = this;
switch (_that) {
case _RawSms() when $default != null:
return $default(_that.sender,_that.body,_that.timestampMillis);case _:
  return null;

}
}

}

/// @nodoc


class _RawSms implements RawSms {
  const _RawSms({required this.sender, required this.body, required this.timestampMillis});
  

@override final  String sender;
@override final  String body;
@override final  int timestampMillis;

/// Create a copy of RawSms
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RawSmsCopyWith<_RawSms> get copyWith => __$RawSmsCopyWithImpl<_RawSms>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RawSms&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.body, body) || other.body == body)&&(identical(other.timestampMillis, timestampMillis) || other.timestampMillis == timestampMillis));
}


@override
int get hashCode {
    return Object.hash(runtimeType,sender,body,timestampMillis);
}

@override
String toString() {
    return 'RawSms(sender: $sender, body: $body, timestampMillis: $timestampMillis)';
}


}

/// @nodoc
abstract mixin class _$RawSmsCopyWith<$Res> implements $RawSmsCopyWith<$Res> {
  factory _$RawSmsCopyWith(_RawSms value, $Res Function(_RawSms) _then) = __$RawSmsCopyWithImpl;
@override @useResult
$Res call({
 String sender, String body, int timestampMillis
});




}
/// @nodoc
class __$RawSmsCopyWithImpl<$Res>
    implements _$RawSmsCopyWith<$Res> {
  __$RawSmsCopyWithImpl(this._self, this._then);

  final _RawSms _self;
  final $Res Function(_RawSms) _then;

/// Create a copy of RawSms
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sender = null,Object? body = null,Object? timestampMillis = null,}) {
  return _then(_RawSms(
sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,timestampMillis: null == timestampMillis ? _self.timestampMillis : timestampMillis // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$QueuedSms {

 int get id; String get sender; String get body; int get receivedAt;
/// Create a copy of QueuedSms
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueuedSmsCopyWith<QueuedSms> get copyWith => _$QueuedSmsCopyWithImpl<QueuedSms>(this as QueuedSms, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QueuedSms;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueuedSms&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.sender, _this.sender) || other.sender == _this.sender)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.receivedAt, _this.receivedAt) || other.receivedAt == _this.receivedAt));
}


@override
int get hashCode {
  final _this = this as QueuedSms;
  return Object.hash(runtimeType,_this.id,_this.sender,_this.body,_this.receivedAt);
}

@override
String toString() {
  final _this = this as QueuedSms;
  return 'QueuedSms(id: ${_this.id}, sender: ${_this.sender}, body: ${_this.body}, receivedAt: ${_this.receivedAt})';
}


}

/// @nodoc
abstract mixin class $QueuedSmsCopyWith<$Res>  {
  factory $QueuedSmsCopyWith(QueuedSms value, $Res Function(QueuedSms) _then) = _$QueuedSmsCopyWithImpl;
@useResult
$Res call({
 int id, String sender, String body, int receivedAt
});




}
/// @nodoc
class _$QueuedSmsCopyWithImpl<$Res>
    implements $QueuedSmsCopyWith<$Res> {
  _$QueuedSmsCopyWithImpl(this._self, this._then);

  final QueuedSms _self;
  final $Res Function(QueuedSms) _then;

/// Create a copy of QueuedSms
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sender = null,Object? body = null,Object? receivedAt = null,}) {
  return _then(QueuedSms(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [QueuedSms].
extension QueuedSmsPatterns on QueuedSms {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueuedSms value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueuedSms() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueuedSms value)  $default,){
final _that = this;
switch (_that) {
case _QueuedSms():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueuedSms value)?  $default,){
final _that = this;
switch (_that) {
case _QueuedSms() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String sender,  String body,  int receivedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueuedSms() when $default != null:
return $default(_that.id,_that.sender,_that.body,_that.receivedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String sender,  String body,  int receivedAt)  $default,) {final _that = this;
switch (_that) {
case _QueuedSms():
return $default(_that.id,_that.sender,_that.body,_that.receivedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String sender,  String body,  int receivedAt)?  $default,) {final _that = this;
switch (_that) {
case _QueuedSms() when $default != null:
return $default(_that.id,_that.sender,_that.body,_that.receivedAt);case _:
  return null;

}
}

}

/// @nodoc


class _QueuedSms implements QueuedSms {
  const _QueuedSms({required this.id, required this.sender, required this.body, required this.receivedAt});
  

@override final  int id;
@override final  String sender;
@override final  String body;
@override final  int receivedAt;

/// Create a copy of QueuedSms
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueuedSmsCopyWith<_QueuedSms> get copyWith => __$QueuedSmsCopyWithImpl<_QueuedSms>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueuedSms&&(identical(other.id, id) || other.id == id)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.body, body) || other.body == body)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,sender,body,receivedAt);
}

@override
String toString() {
    return 'QueuedSms(id: $id, sender: $sender, body: $body, receivedAt: $receivedAt)';
}


}

/// @nodoc
abstract mixin class _$QueuedSmsCopyWith<$Res> implements $QueuedSmsCopyWith<$Res> {
  factory _$QueuedSmsCopyWith(_QueuedSms value, $Res Function(_QueuedSms) _then) = __$QueuedSmsCopyWithImpl;
@override @useResult
$Res call({
 int id, String sender, String body, int receivedAt
});




}
/// @nodoc
class __$QueuedSmsCopyWithImpl<$Res>
    implements _$QueuedSmsCopyWith<$Res> {
  __$QueuedSmsCopyWithImpl(this._self, this._then);

  final _QueuedSms _self;
  final $Res Function(_QueuedSms) _then;

/// Create a copy of QueuedSms
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sender = null,Object? body = null,Object? receivedAt = null,}) {
  return _then(_QueuedSms(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
