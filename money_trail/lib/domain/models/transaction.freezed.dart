// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Transaction {

/// 0 until the row has been inserted.
 int get id; int get amountPaise; TransactionType get type; TransactionSource get source;/// Null when the merchant could not be extracted or was left blank.
 String? get merchant; String get category;/// SMS timestamp, or entry time for manual rows.
 DateTime get txnTimestamp; bool get isManual;/// The next three are always null for manual rows, which keeps manual
/// entries out of the message_hash uniqueness check entirely.
 String? get rawSmsBody; String? get sender; String? get messageHash; DateTime get createdAt;
/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionCopyWith<Transaction> get copyWith => _$TransactionCopyWithImpl<Transaction>(this as Transaction, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Transaction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transaction&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.amountPaise, _this.amountPaise) || other.amountPaise == _this.amountPaise)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.merchant, _this.merchant) || other.merchant == _this.merchant)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.txnTimestamp, _this.txnTimestamp) || other.txnTimestamp == _this.txnTimestamp)&&(identical(other.isManual, _this.isManual) || other.isManual == _this.isManual)&&(identical(other.rawSmsBody, _this.rawSmsBody) || other.rawSmsBody == _this.rawSmsBody)&&(identical(other.sender, _this.sender) || other.sender == _this.sender)&&(identical(other.messageHash, _this.messageHash) || other.messageHash == _this.messageHash)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as Transaction;
  return Object.hash(runtimeType,_this.id,_this.amountPaise,_this.type,_this.source,_this.merchant,_this.category,_this.txnTimestamp,_this.isManual,_this.rawSmsBody,_this.sender,_this.messageHash,_this.createdAt);
}

@override
String toString() {
  final _this = this as Transaction;
  return 'Transaction(id: ${_this.id}, amountPaise: ${_this.amountPaise}, type: ${_this.type}, source: ${_this.source}, merchant: ${_this.merchant}, category: ${_this.category}, txnTimestamp: ${_this.txnTimestamp}, isManual: ${_this.isManual}, rawSmsBody: ${_this.rawSmsBody}, sender: ${_this.sender}, messageHash: ${_this.messageHash}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $TransactionCopyWith<$Res>  {
  factory $TransactionCopyWith(Transaction value, $Res Function(Transaction) _then) = _$TransactionCopyWithImpl;
@useResult
$Res call({
 int id, int amountPaise, TransactionType type, TransactionSource source, String? merchant, String category, DateTime txnTimestamp, bool isManual, String? rawSmsBody, String? sender, String? messageHash, DateTime createdAt
});




}
/// @nodoc
class _$TransactionCopyWithImpl<$Res>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._self, this._then);

  final Transaction _self;
  final $Res Function(Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amountPaise = null,Object? type = null,Object? source = null,Object? merchant = freezed,Object? category = null,Object? txnTimestamp = null,Object? isManual = null,Object? rawSmsBody = freezed,Object? sender = freezed,Object? messageHash = freezed,Object? createdAt = null,}) {
  return _then(Transaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as TransactionSource,merchant: freezed == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,txnTimestamp: null == txnTimestamp ? _self.txnTimestamp : txnTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isManual: null == isManual ? _self.isManual : isManual // ignore: cast_nullable_to_non_nullable
as bool,rawSmsBody: freezed == rawSmsBody ? _self.rawSmsBody : rawSmsBody // ignore: cast_nullable_to_non_nullable
as String?,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String?,messageHash: freezed == messageHash ? _self.messageHash : messageHash // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Transaction].
extension TransactionPatterns on Transaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transaction value)  $default,){
final _that = this;
switch (_that) {
case _Transaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transaction value)?  $default,){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int amountPaise,  TransactionType type,  TransactionSource source,  String? merchant,  String category,  DateTime txnTimestamp,  bool isManual,  String? rawSmsBody,  String? sender,  String? messageHash,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.amountPaise,_that.type,_that.source,_that.merchant,_that.category,_that.txnTimestamp,_that.isManual,_that.rawSmsBody,_that.sender,_that.messageHash,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int amountPaise,  TransactionType type,  TransactionSource source,  String? merchant,  String category,  DateTime txnTimestamp,  bool isManual,  String? rawSmsBody,  String? sender,  String? messageHash,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Transaction():
return $default(_that.id,_that.amountPaise,_that.type,_that.source,_that.merchant,_that.category,_that.txnTimestamp,_that.isManual,_that.rawSmsBody,_that.sender,_that.messageHash,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int amountPaise,  TransactionType type,  TransactionSource source,  String? merchant,  String category,  DateTime txnTimestamp,  bool isManual,  String? rawSmsBody,  String? sender,  String? messageHash,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.amountPaise,_that.type,_that.source,_that.merchant,_that.category,_that.txnTimestamp,_that.isManual,_that.rawSmsBody,_that.sender,_that.messageHash,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Transaction implements Transaction {
  const _Transaction({this.id = 0, required this.amountPaise, required this.type, required this.source, this.merchant, this.category = kUncategorized, required this.txnTimestamp, required this.isManual, this.rawSmsBody, this.sender, this.messageHash, required this.createdAt});
  

/// 0 until the row has been inserted.
@override@JsonKey() final  int id;
@override final  int amountPaise;
@override final  TransactionType type;
@override final  TransactionSource source;
/// Null when the merchant could not be extracted or was left blank.
@override final  String? merchant;
@override@JsonKey() final  String category;
/// SMS timestamp, or entry time for manual rows.
@override final  DateTime txnTimestamp;
@override final  bool isManual;
/// The next three are always null for manual rows, which keeps manual
/// entries out of the message_hash uniqueness check entirely.
@override final  String? rawSmsBody;
@override final  String? sender;
@override final  String? messageHash;
@override final  DateTime createdAt;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCopyWith<_Transaction> get copyWith => __$TransactionCopyWithImpl<_Transaction>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.amountPaise, amountPaise) || other.amountPaise == amountPaise)&&(identical(other.type, type) || other.type == type)&&(identical(other.source, source) || other.source == source)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.category, category) || other.category == category)&&(identical(other.txnTimestamp, txnTimestamp) || other.txnTimestamp == txnTimestamp)&&(identical(other.isManual, isManual) || other.isManual == isManual)&&(identical(other.rawSmsBody, rawSmsBody) || other.rawSmsBody == rawSmsBody)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.messageHash, messageHash) || other.messageHash == messageHash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,amountPaise,type,source,merchant,category,txnTimestamp,isManual,rawSmsBody,sender,messageHash,createdAt);
}

@override
String toString() {
    return 'Transaction(id: $id, amountPaise: $amountPaise, type: $type, source: $source, merchant: $merchant, category: $category, txnTimestamp: $txnTimestamp, isManual: $isManual, rawSmsBody: $rawSmsBody, sender: $sender, messageHash: $messageHash, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TransactionCopyWith<$Res> implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(_Transaction value, $Res Function(_Transaction) _then) = __$TransactionCopyWithImpl;
@override @useResult
$Res call({
 int id, int amountPaise, TransactionType type, TransactionSource source, String? merchant, String category, DateTime txnTimestamp, bool isManual, String? rawSmsBody, String? sender, String? messageHash, DateTime createdAt
});




}
/// @nodoc
class __$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(this._self, this._then);

  final _Transaction _self;
  final $Res Function(_Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amountPaise = null,Object? type = null,Object? source = null,Object? merchant = freezed,Object? category = null,Object? txnTimestamp = null,Object? isManual = null,Object? rawSmsBody = freezed,Object? sender = freezed,Object? messageHash = freezed,Object? createdAt = null,}) {
  return _then(_Transaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,amountPaise: null == amountPaise ? _self.amountPaise : amountPaise // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as TransactionSource,merchant: freezed == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,txnTimestamp: null == txnTimestamp ? _self.txnTimestamp : txnTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isManual: null == isManual ? _self.isManual : isManual // ignore: cast_nullable_to_non_nullable
as bool,rawSmsBody: freezed == rawSmsBody ? _self.rawSmsBody : rawSmsBody // ignore: cast_nullable_to_non_nullable
as String?,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String?,messageHash: freezed == messageHash ? _self.messageHash : messageHash // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
