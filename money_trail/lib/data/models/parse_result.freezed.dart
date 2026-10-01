// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parse_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParseResult {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ParseResult()';
}


}

/// @nodoc
class $ParseResultCopyWith<$Res>  {
$ParseResultCopyWith(ParseResult _, $Res Function(ParseResult) __);
}


/// Adds pattern-matching-related methods to [ParseResult].
extension ParseResultPatterns on ParseResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ParseSuccess value)?  success,TResult Function( ParseSkipped value)?  skipped,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ParseSuccess() when success != null:
return success(_that);case ParseSkipped() when skipped != null:
return skipped(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ParseSuccess value)  success,required TResult Function( ParseSkipped value)  skipped,}){
final _that = this;
switch (_that) {
case ParseSuccess():
return success(_that);case ParseSkipped():
return skipped(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ParseSuccess value)?  success,TResult? Function( ParseSkipped value)?  skipped,}){
final _that = this;
switch (_that) {
case ParseSuccess() when success != null:
return success(_that);case ParseSkipped() when skipped != null:
return skipped(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Transaction transaction)?  success,TResult Function( SkipReason reason)?  skipped,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ParseSuccess() when success != null:
return success(_that.transaction);case ParseSkipped() when skipped != null:
return skipped(_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Transaction transaction)  success,required TResult Function( SkipReason reason)  skipped,}) {final _that = this;
switch (_that) {
case ParseSuccess():
return success(_that.transaction);case ParseSkipped():
return skipped(_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Transaction transaction)?  success,TResult? Function( SkipReason reason)?  skipped,}) {final _that = this;
switch (_that) {
case ParseSuccess() when success != null:
return success(_that.transaction);case ParseSkipped() when skipped != null:
return skipped(_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class ParseSuccess implements ParseResult {
  const ParseSuccess(this.transaction);
  

 final  Transaction transaction;

/// Create a copy of ParseResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseSuccessCopyWith<ParseSuccess> get copyWith => _$ParseSuccessCopyWithImpl<ParseSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseSuccess&&(identical(other.transaction, transaction) || other.transaction == transaction));
}


@override
int get hashCode {
    return Object.hash(runtimeType,transaction);
}

@override
String toString() {
    return 'ParseResult.success(transaction: $transaction)';
}


}

/// @nodoc
abstract mixin class $ParseSuccessCopyWith<$Res> implements $ParseResultCopyWith<$Res> {
  factory $ParseSuccessCopyWith(ParseSuccess value, $Res Function(ParseSuccess) _then) = _$ParseSuccessCopyWithImpl;
@useResult
$Res call({
 Transaction transaction
});


$TransactionCopyWith<$Res> get transaction;

}
/// @nodoc
class _$ParseSuccessCopyWithImpl<$Res>
    implements $ParseSuccessCopyWith<$Res> {
  _$ParseSuccessCopyWithImpl(this._self, this._then);

  final ParseSuccess _self;
  final $Res Function(ParseSuccess) _then;

/// Create a copy of ParseResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transaction = null,}) {
  return _then(ParseSuccess(
null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as Transaction,
  ));
}

/// Create a copy of ParseResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionCopyWith<$Res> get transaction {
  
  return $TransactionCopyWith<$Res>(_self.transaction, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}
}

/// @nodoc


class ParseSkipped implements ParseResult {
  const ParseSkipped(this.reason);
  

 final  SkipReason reason;

/// Create a copy of ParseResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseSkippedCopyWith<ParseSkipped> get copyWith => _$ParseSkippedCopyWithImpl<ParseSkipped>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseSkipped&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reason);
}

@override
String toString() {
    return 'ParseResult.skipped(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $ParseSkippedCopyWith<$Res> implements $ParseResultCopyWith<$Res> {
  factory $ParseSkippedCopyWith(ParseSkipped value, $Res Function(ParseSkipped) _then) = _$ParseSkippedCopyWithImpl;
@useResult
$Res call({
 SkipReason reason
});




}
/// @nodoc
class _$ParseSkippedCopyWithImpl<$Res>
    implements $ParseSkippedCopyWith<$Res> {
  _$ParseSkippedCopyWithImpl(this._self, this._then);

  final ParseSkipped _self;
  final $Res Function(ParseSkipped) _then;

/// Create a copy of ParseResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(ParseSkipped(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as SkipReason,
  ));
}


}

// dart format on
