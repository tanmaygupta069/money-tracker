// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta(
    'amountPaise',
  );
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
    'amount_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantMeta = const VerificationMeta(
    'merchant',
  );
  @override
  late final GeneratedColumn<String> merchant = GeneratedColumn<String>(
    'merchant',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('uncategorized'),
  );
  static const VerificationMeta _txnTimestampMeta = const VerificationMeta(
    'txnTimestamp',
  );
  @override
  late final GeneratedColumn<int> txnTimestamp = GeneratedColumn<int>(
    'txn_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isManualMeta = const VerificationMeta(
    'isManual',
  );
  @override
  late final GeneratedColumn<bool> isManual = GeneratedColumn<bool>(
    'is_manual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_manual" IN (0, 1))',
    ),
  );
  static const VerificationMeta _rawSmsBodyMeta = const VerificationMeta(
    'rawSmsBody',
  );
  @override
  late final GeneratedColumn<String> rawSmsBody = GeneratedColumn<String>(
    'raw_sms_body',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
    'sender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _messageHashMeta = const VerificationMeta(
    'messageHash',
  );
  @override
  late final GeneratedColumn<String> messageHash = GeneratedColumn<String>(
    'message_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amountPaise,
    type,
    source,
    merchant,
    category,
    txnTimestamp,
    isManual,
    rawSmsBody,
    sender,
    messageHash,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
        _amountPaiseMeta,
        amountPaise.isAcceptableOrUnknown(
          data['amount_paise']!,
          _amountPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('merchant')) {
      context.handle(
        _merchantMeta,
        merchant.isAcceptableOrUnknown(data['merchant']!, _merchantMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('txn_timestamp')) {
      context.handle(
        _txnTimestampMeta,
        txnTimestamp.isAcceptableOrUnknown(
          data['txn_timestamp']!,
          _txnTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_txnTimestampMeta);
    }
    if (data.containsKey('is_manual')) {
      context.handle(
        _isManualMeta,
        isManual.isAcceptableOrUnknown(data['is_manual']!, _isManualMeta),
      );
    } else if (isInserting) {
      context.missing(_isManualMeta);
    }
    if (data.containsKey('raw_sms_body')) {
      context.handle(
        _rawSmsBodyMeta,
        rawSmsBody.isAcceptableOrUnknown(
          data['raw_sms_body']!,
          _rawSmsBodyMeta,
        ),
      );
    }
    if (data.containsKey('sender')) {
      context.handle(
        _senderMeta,
        sender.isAcceptableOrUnknown(data['sender']!, _senderMeta),
      );
    }
    if (data.containsKey('message_hash')) {
      context.handle(
        _messageHashMeta,
        messageHash.isAcceptableOrUnknown(
          data['message_hash']!,
          _messageHashMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      amountPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_paise'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      merchant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      txnTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}txn_timestamp'],
      )!,
      isManual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_manual'],
      )!,
      rawSmsBody: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_sms_body'],
      ),
      sender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender'],
      ),
      messageHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_hash'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class TransactionRow extends DataClass implements Insertable<TransactionRow> {
  final int id;

  /// Integer paise, never a float.
  final int amountPaise;

  /// Uppercase enum name, `DEBIT` or `CREDIT`.
  final String type;

  /// Uppercase enum name, `KOTAK`, `SLICE`, `GPAY_MANUAL` or `CASH_MANUAL`.
  final String source;
  final String? merchant;
  final String category;

  /// Epoch millis: the SMS timestamp, or entry time for manual rows.
  final int txnTimestamp;
  final bool isManual;
  final String? rawSmsBody;
  final String? sender;

  /// sha256(body + timestamp). Null for manual rows, and SQLite permits many
  /// NULLs in a unique index, so manual entries never collide.
  final String? messageHash;
  final int createdAt;
  const TransactionRow({
    required this.id,
    required this.amountPaise,
    required this.type,
    required this.source,
    this.merchant,
    required this.category,
    required this.txnTimestamp,
    required this.isManual,
    this.rawSmsBody,
    this.sender,
    this.messageHash,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount_paise'] = Variable<int>(amountPaise);
    map['type'] = Variable<String>(type);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || merchant != null) {
      map['merchant'] = Variable<String>(merchant);
    }
    map['category'] = Variable<String>(category);
    map['txn_timestamp'] = Variable<int>(txnTimestamp);
    map['is_manual'] = Variable<bool>(isManual);
    if (!nullToAbsent || rawSmsBody != null) {
      map['raw_sms_body'] = Variable<String>(rawSmsBody);
    }
    if (!nullToAbsent || sender != null) {
      map['sender'] = Variable<String>(sender);
    }
    if (!nullToAbsent || messageHash != null) {
      map['message_hash'] = Variable<String>(messageHash);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      amountPaise: Value(amountPaise),
      type: Value(type),
      source: Value(source),
      merchant: merchant == null && nullToAbsent
          ? const Value.absent()
          : Value(merchant),
      category: Value(category),
      txnTimestamp: Value(txnTimestamp),
      isManual: Value(isManual),
      rawSmsBody: rawSmsBody == null && nullToAbsent
          ? const Value.absent()
          : Value(rawSmsBody),
      sender: sender == null && nullToAbsent
          ? const Value.absent()
          : Value(sender),
      messageHash: messageHash == null && nullToAbsent
          ? const Value.absent()
          : Value(messageHash),
      createdAt: Value(createdAt),
    );
  }

  factory TransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionRow(
      id: serializer.fromJson<int>(json['id']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      type: serializer.fromJson<String>(json['type']),
      source: serializer.fromJson<String>(json['source']),
      merchant: serializer.fromJson<String?>(json['merchant']),
      category: serializer.fromJson<String>(json['category']),
      txnTimestamp: serializer.fromJson<int>(json['txnTimestamp']),
      isManual: serializer.fromJson<bool>(json['isManual']),
      rawSmsBody: serializer.fromJson<String?>(json['rawSmsBody']),
      sender: serializer.fromJson<String?>(json['sender']),
      messageHash: serializer.fromJson<String?>(json['messageHash']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'type': serializer.toJson<String>(type),
      'source': serializer.toJson<String>(source),
      'merchant': serializer.toJson<String?>(merchant),
      'category': serializer.toJson<String>(category),
      'txnTimestamp': serializer.toJson<int>(txnTimestamp),
      'isManual': serializer.toJson<bool>(isManual),
      'rawSmsBody': serializer.toJson<String?>(rawSmsBody),
      'sender': serializer.toJson<String?>(sender),
      'messageHash': serializer.toJson<String?>(messageHash),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  TransactionRow copyWith({
    int? id,
    int? amountPaise,
    String? type,
    String? source,
    Value<String?> merchant = const Value.absent(),
    String? category,
    int? txnTimestamp,
    bool? isManual,
    Value<String?> rawSmsBody = const Value.absent(),
    Value<String?> sender = const Value.absent(),
    Value<String?> messageHash = const Value.absent(),
    int? createdAt,
  }) => TransactionRow(
    id: id ?? this.id,
    amountPaise: amountPaise ?? this.amountPaise,
    type: type ?? this.type,
    source: source ?? this.source,
    merchant: merchant.present ? merchant.value : this.merchant,
    category: category ?? this.category,
    txnTimestamp: txnTimestamp ?? this.txnTimestamp,
    isManual: isManual ?? this.isManual,
    rawSmsBody: rawSmsBody.present ? rawSmsBody.value : this.rawSmsBody,
    sender: sender.present ? sender.value : this.sender,
    messageHash: messageHash.present ? messageHash.value : this.messageHash,
    createdAt: createdAt ?? this.createdAt,
  );
  TransactionRow copyWithCompanion(TransactionsCompanion data) {
    return TransactionRow(
      id: data.id.present ? data.id.value : this.id,
      amountPaise: data.amountPaise.present
          ? data.amountPaise.value
          : this.amountPaise,
      type: data.type.present ? data.type.value : this.type,
      source: data.source.present ? data.source.value : this.source,
      merchant: data.merchant.present ? data.merchant.value : this.merchant,
      category: data.category.present ? data.category.value : this.category,
      txnTimestamp: data.txnTimestamp.present
          ? data.txnTimestamp.value
          : this.txnTimestamp,
      isManual: data.isManual.present ? data.isManual.value : this.isManual,
      rawSmsBody: data.rawSmsBody.present
          ? data.rawSmsBody.value
          : this.rawSmsBody,
      sender: data.sender.present ? data.sender.value : this.sender,
      messageHash: data.messageHash.present
          ? data.messageHash.value
          : this.messageHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionRow(')
          ..write('id: $id, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('type: $type, ')
          ..write('source: $source, ')
          ..write('merchant: $merchant, ')
          ..write('category: $category, ')
          ..write('txnTimestamp: $txnTimestamp, ')
          ..write('isManual: $isManual, ')
          ..write('rawSmsBody: $rawSmsBody, ')
          ..write('sender: $sender, ')
          ..write('messageHash: $messageHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    amountPaise,
    type,
    source,
    merchant,
    category,
    txnTimestamp,
    isManual,
    rawSmsBody,
    sender,
    messageHash,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionRow &&
          other.id == this.id &&
          other.amountPaise == this.amountPaise &&
          other.type == this.type &&
          other.source == this.source &&
          other.merchant == this.merchant &&
          other.category == this.category &&
          other.txnTimestamp == this.txnTimestamp &&
          other.isManual == this.isManual &&
          other.rawSmsBody == this.rawSmsBody &&
          other.sender == this.sender &&
          other.messageHash == this.messageHash &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<TransactionRow> {
  final Value<int> id;
  final Value<int> amountPaise;
  final Value<String> type;
  final Value<String> source;
  final Value<String?> merchant;
  final Value<String> category;
  final Value<int> txnTimestamp;
  final Value<bool> isManual;
  final Value<String?> rawSmsBody;
  final Value<String?> sender;
  final Value<String?> messageHash;
  final Value<int> createdAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.type = const Value.absent(),
    this.source = const Value.absent(),
    this.merchant = const Value.absent(),
    this.category = const Value.absent(),
    this.txnTimestamp = const Value.absent(),
    this.isManual = const Value.absent(),
    this.rawSmsBody = const Value.absent(),
    this.sender = const Value.absent(),
    this.messageHash = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int amountPaise,
    required String type,
    required String source,
    this.merchant = const Value.absent(),
    this.category = const Value.absent(),
    required int txnTimestamp,
    required bool isManual,
    this.rawSmsBody = const Value.absent(),
    this.sender = const Value.absent(),
    this.messageHash = const Value.absent(),
    required int createdAt,
  }) : amountPaise = Value(amountPaise),
       type = Value(type),
       source = Value(source),
       txnTimestamp = Value(txnTimestamp),
       isManual = Value(isManual),
       createdAt = Value(createdAt);
  static Insertable<TransactionRow> custom({
    Expression<int>? id,
    Expression<int>? amountPaise,
    Expression<String>? type,
    Expression<String>? source,
    Expression<String>? merchant,
    Expression<String>? category,
    Expression<int>? txnTimestamp,
    Expression<bool>? isManual,
    Expression<String>? rawSmsBody,
    Expression<String>? sender,
    Expression<String>? messageHash,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (type != null) 'type': type,
      if (source != null) 'source': source,
      if (merchant != null) 'merchant': merchant,
      if (category != null) 'category': category,
      if (txnTimestamp != null) 'txn_timestamp': txnTimestamp,
      if (isManual != null) 'is_manual': isManual,
      if (rawSmsBody != null) 'raw_sms_body': rawSmsBody,
      if (sender != null) 'sender': sender,
      if (messageHash != null) 'message_hash': messageHash,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? amountPaise,
    Value<String>? type,
    Value<String>? source,
    Value<String?>? merchant,
    Value<String>? category,
    Value<int>? txnTimestamp,
    Value<bool>? isManual,
    Value<String?>? rawSmsBody,
    Value<String?>? sender,
    Value<String?>? messageHash,
    Value<int>? createdAt,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      amountPaise: amountPaise ?? this.amountPaise,
      type: type ?? this.type,
      source: source ?? this.source,
      merchant: merchant ?? this.merchant,
      category: category ?? this.category,
      txnTimestamp: txnTimestamp ?? this.txnTimestamp,
      isManual: isManual ?? this.isManual,
      rawSmsBody: rawSmsBody ?? this.rawSmsBody,
      sender: sender ?? this.sender,
      messageHash: messageHash ?? this.messageHash,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (merchant.present) {
      map['merchant'] = Variable<String>(merchant.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (txnTimestamp.present) {
      map['txn_timestamp'] = Variable<int>(txnTimestamp.value);
    }
    if (isManual.present) {
      map['is_manual'] = Variable<bool>(isManual.value);
    }
    if (rawSmsBody.present) {
      map['raw_sms_body'] = Variable<String>(rawSmsBody.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (messageHash.present) {
      map['message_hash'] = Variable<String>(messageHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('type: $type, ')
          ..write('source: $source, ')
          ..write('merchant: $merchant, ')
          ..write('category: $category, ')
          ..write('txnTimestamp: $txnTimestamp, ')
          ..write('isManual: $isManual, ')
          ..write('rawSmsBody: $rawSmsBody, ')
          ..write('sender: $sender, ')
          ..write('messageHash: $messageHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CategoryRulesTable extends CategoryRules
    with TableInfo<$CategoryRulesTable, CategoryRuleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _keywordMeta = const VerificationMeta(
    'keyword',
  );
  @override
  late final GeneratedColumn<String> keyword = GeneratedColumn<String>(
    'keyword',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, keyword, category, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryRuleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('keyword')) {
      context.handle(
        _keywordMeta,
        keyword.isAcceptableOrUnknown(data['keyword']!, _keywordMeta),
      );
    } else if (isInserting) {
      context.missing(_keywordMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryRuleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRuleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      keyword: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keyword'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
    );
  }

  @override
  $CategoryRulesTable createAlias(String alias) {
    return $CategoryRulesTable(attachedDatabase, alias);
  }
}

class CategoryRuleRow extends DataClass implements Insertable<CategoryRuleRow> {
  final int id;
  final String keyword;
  final String category;
  final int priority;
  const CategoryRuleRow({
    required this.id,
    required this.keyword,
    required this.category,
    required this.priority,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['keyword'] = Variable<String>(keyword);
    map['category'] = Variable<String>(category);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  CategoryRulesCompanion toCompanion(bool nullToAbsent) {
    return CategoryRulesCompanion(
      id: Value(id),
      keyword: Value(keyword),
      category: Value(category),
      priority: Value(priority),
    );
  }

  factory CategoryRuleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRuleRow(
      id: serializer.fromJson<int>(json['id']),
      keyword: serializer.fromJson<String>(json['keyword']),
      category: serializer.fromJson<String>(json['category']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'keyword': serializer.toJson<String>(keyword),
      'category': serializer.toJson<String>(category),
      'priority': serializer.toJson<int>(priority),
    };
  }

  CategoryRuleRow copyWith({
    int? id,
    String? keyword,
    String? category,
    int? priority,
  }) => CategoryRuleRow(
    id: id ?? this.id,
    keyword: keyword ?? this.keyword,
    category: category ?? this.category,
    priority: priority ?? this.priority,
  );
  CategoryRuleRow copyWithCompanion(CategoryRulesCompanion data) {
    return CategoryRuleRow(
      id: data.id.present ? data.id.value : this.id,
      keyword: data.keyword.present ? data.keyword.value : this.keyword,
      category: data.category.present ? data.category.value : this.category,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRuleRow(')
          ..write('id: $id, ')
          ..write('keyword: $keyword, ')
          ..write('category: $category, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, keyword, category, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRuleRow &&
          other.id == this.id &&
          other.keyword == this.keyword &&
          other.category == this.category &&
          other.priority == this.priority);
}

class CategoryRulesCompanion extends UpdateCompanion<CategoryRuleRow> {
  final Value<int> id;
  final Value<String> keyword;
  final Value<String> category;
  final Value<int> priority;
  const CategoryRulesCompanion({
    this.id = const Value.absent(),
    this.keyword = const Value.absent(),
    this.category = const Value.absent(),
    this.priority = const Value.absent(),
  });
  CategoryRulesCompanion.insert({
    this.id = const Value.absent(),
    required String keyword,
    required String category,
    this.priority = const Value.absent(),
  }) : keyword = Value(keyword),
       category = Value(category);
  static Insertable<CategoryRuleRow> custom({
    Expression<int>? id,
    Expression<String>? keyword,
    Expression<String>? category,
    Expression<int>? priority,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (keyword != null) 'keyword': keyword,
      if (category != null) 'category': category,
      if (priority != null) 'priority': priority,
    });
  }

  CategoryRulesCompanion copyWith({
    Value<int>? id,
    Value<String>? keyword,
    Value<String>? category,
    Value<int>? priority,
  }) {
    return CategoryRulesCompanion(
      id: id ?? this.id,
      keyword: keyword ?? this.keyword,
      category: category ?? this.category,
      priority: priority ?? this.priority,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (keyword.present) {
      map['keyword'] = Variable<String>(keyword.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRulesCompanion(')
          ..write('id: $id, ')
          ..write('keyword: $keyword, ')
          ..write('category: $category, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }
}

class $SenderAllowlistTable extends SenderAllowlist
    with TableInfo<$SenderAllowlistTable, SenderAllowlistRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SenderAllowlistTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, enabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sender_allowlist';
  @override
  VerificationContext validateIntegrity(
    Insertable<SenderAllowlistRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SenderAllowlistRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SenderAllowlistRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $SenderAllowlistTable createAlias(String alias) {
    return $SenderAllowlistTable(attachedDatabase, alias);
  }
}

class SenderAllowlistRow extends DataClass
    implements Insertable<SenderAllowlistRow> {
  final int id;
  final String name;
  final bool enabled;
  const SenderAllowlistRow({
    required this.id,
    required this.name,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  SenderAllowlistCompanion toCompanion(bool nullToAbsent) {
    return SenderAllowlistCompanion(
      id: Value(id),
      name: Value(name),
      enabled: Value(enabled),
    );
  }

  factory SenderAllowlistRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SenderAllowlistRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  SenderAllowlistRow copyWith({int? id, String? name, bool? enabled}) =>
      SenderAllowlistRow(
        id: id ?? this.id,
        name: name ?? this.name,
        enabled: enabled ?? this.enabled,
      );
  SenderAllowlistRow copyWithCompanion(SenderAllowlistCompanion data) {
    return SenderAllowlistRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SenderAllowlistRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, enabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SenderAllowlistRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.enabled == this.enabled);
}

class SenderAllowlistCompanion extends UpdateCompanion<SenderAllowlistRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> enabled;
  const SenderAllowlistCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.enabled = const Value.absent(),
  });
  SenderAllowlistCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.enabled = const Value.absent(),
  }) : name = Value(name);
  static Insertable<SenderAllowlistRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? enabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (enabled != null) 'enabled': enabled,
    });
  }

  SenderAllowlistCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<bool>? enabled,
  }) {
    return SenderAllowlistCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SenderAllowlistCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }
}

class $SyncStatesTable extends SyncStates
    with TableInfo<$SyncStatesTable, SyncStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstRunWindowDaysMeta =
      const VerificationMeta('firstRunWindowDays');
  @override
  late final GeneratedColumn<int> firstRunWindowDays = GeneratedColumn<int>(
    'first_run_window_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  @override
  List<GeneratedColumn> get $columns => [id, lastSyncedAt, firstRunWindowDays];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('first_run_window_days')) {
      context.handle(
        _firstRunWindowDaysMeta,
        firstRunWindowDays.isAcceptableOrUnknown(
          data['first_run_window_days']!,
          _firstRunWindowDaysMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_synced_at'],
      ),
      firstRunWindowDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}first_run_window_days'],
      )!,
    );
  }

  @override
  $SyncStatesTable createAlias(String alias) {
    return $SyncStatesTable(attachedDatabase, alias);
  }
}

class SyncStateRow extends DataClass implements Insertable<SyncStateRow> {
  /// Always [kSyncStateSingletonId]; the table holds exactly one row.
  final int id;

  /// Epoch millis, null when the inbox has never been synced.
  final int? lastSyncedAt;
  final int firstRunWindowDays;
  const SyncStateRow({
    required this.id,
    this.lastSyncedAt,
    required this.firstRunWindowDays,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt);
    }
    map['first_run_window_days'] = Variable<int>(firstRunWindowDays);
    return map;
  }

  SyncStatesCompanion toCompanion(bool nullToAbsent) {
    return SyncStatesCompanion(
      id: Value(id),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      firstRunWindowDays: Value(firstRunWindowDays),
    );
  }

  factory SyncStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateRow(
      id: serializer.fromJson<int>(json['id']),
      lastSyncedAt: serializer.fromJson<int?>(json['lastSyncedAt']),
      firstRunWindowDays: serializer.fromJson<int>(json['firstRunWindowDays']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lastSyncedAt': serializer.toJson<int?>(lastSyncedAt),
      'firstRunWindowDays': serializer.toJson<int>(firstRunWindowDays),
    };
  }

  SyncStateRow copyWith({
    int? id,
    Value<int?> lastSyncedAt = const Value.absent(),
    int? firstRunWindowDays,
  }) => SyncStateRow(
    id: id ?? this.id,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    firstRunWindowDays: firstRunWindowDays ?? this.firstRunWindowDays,
  );
  SyncStateRow copyWithCompanion(SyncStatesCompanion data) {
    return SyncStateRow(
      id: data.id.present ? data.id.value : this.id,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      firstRunWindowDays: data.firstRunWindowDays.present
          ? data.firstRunWindowDays.value
          : this.firstRunWindowDays,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateRow(')
          ..write('id: $id, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('firstRunWindowDays: $firstRunWindowDays')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastSyncedAt, firstRunWindowDays);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateRow &&
          other.id == this.id &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.firstRunWindowDays == this.firstRunWindowDays);
}

class SyncStatesCompanion extends UpdateCompanion<SyncStateRow> {
  final Value<int> id;
  final Value<int?> lastSyncedAt;
  final Value<int> firstRunWindowDays;
  const SyncStatesCompanion({
    this.id = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.firstRunWindowDays = const Value.absent(),
  });
  SyncStatesCompanion.insert({
    this.id = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.firstRunWindowDays = const Value.absent(),
  });
  static Insertable<SyncStateRow> custom({
    Expression<int>? id,
    Expression<int>? lastSyncedAt,
    Expression<int>? firstRunWindowDays,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (firstRunWindowDays != null)
        'first_run_window_days': firstRunWindowDays,
    });
  }

  SyncStatesCompanion copyWith({
    Value<int>? id,
    Value<int?>? lastSyncedAt,
    Value<int>? firstRunWindowDays,
  }) {
    return SyncStatesCompanion(
      id: id ?? this.id,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      firstRunWindowDays: firstRunWindowDays ?? this.firstRunWindowDays,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (firstRunWindowDays.present) {
      map['first_run_window_days'] = Variable<int>(firstRunWindowDays.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStatesCompanion(')
          ..write('id: $id, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('firstRunWindowDays: $firstRunWindowDays')
          ..write(')'))
        .toString();
  }
}

class $InboxQueueTable extends InboxQueue
    with TableInfo<$InboxQueueTable, InboxQueueRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InboxQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
    'sender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<int> receivedAt = GeneratedColumn<int>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sender, body, receivedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inbox_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<InboxQueueRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sender')) {
      context.handle(
        _senderMeta,
        sender.isAcceptableOrUnknown(data['sender']!, _senderMeta),
      );
    } else if (isInserting) {
      context.missing(_senderMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InboxQueueRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InboxQueueRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}received_at'],
      )!,
    );
  }

  @override
  $InboxQueueTable createAlias(String alias) {
    return $InboxQueueTable(attachedDatabase, alias);
  }
}

class InboxQueueRow extends DataClass implements Insertable<InboxQueueRow> {
  final int id;
  final String sender;
  final String body;
  final int receivedAt;
  const InboxQueueRow({
    required this.id,
    required this.sender,
    required this.body,
    required this.receivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sender'] = Variable<String>(sender);
    map['body'] = Variable<String>(body);
    map['received_at'] = Variable<int>(receivedAt);
    return map;
  }

  InboxQueueCompanion toCompanion(bool nullToAbsent) {
    return InboxQueueCompanion(
      id: Value(id),
      sender: Value(sender),
      body: Value(body),
      receivedAt: Value(receivedAt),
    );
  }

  factory InboxQueueRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InboxQueueRow(
      id: serializer.fromJson<int>(json['id']),
      sender: serializer.fromJson<String>(json['sender']),
      body: serializer.fromJson<String>(json['body']),
      receivedAt: serializer.fromJson<int>(json['receivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sender': serializer.toJson<String>(sender),
      'body': serializer.toJson<String>(body),
      'receivedAt': serializer.toJson<int>(receivedAt),
    };
  }

  InboxQueueRow copyWith({
    int? id,
    String? sender,
    String? body,
    int? receivedAt,
  }) => InboxQueueRow(
    id: id ?? this.id,
    sender: sender ?? this.sender,
    body: body ?? this.body,
    receivedAt: receivedAt ?? this.receivedAt,
  );
  InboxQueueRow copyWithCompanion(InboxQueueCompanion data) {
    return InboxQueueRow(
      id: data.id.present ? data.id.value : this.id,
      sender: data.sender.present ? data.sender.value : this.sender,
      body: data.body.present ? data.body.value : this.body,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InboxQueueRow(')
          ..write('id: $id, ')
          ..write('sender: $sender, ')
          ..write('body: $body, ')
          ..write('receivedAt: $receivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sender, body, receivedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InboxQueueRow &&
          other.id == this.id &&
          other.sender == this.sender &&
          other.body == this.body &&
          other.receivedAt == this.receivedAt);
}

class InboxQueueCompanion extends UpdateCompanion<InboxQueueRow> {
  final Value<int> id;
  final Value<String> sender;
  final Value<String> body;
  final Value<int> receivedAt;
  const InboxQueueCompanion({
    this.id = const Value.absent(),
    this.sender = const Value.absent(),
    this.body = const Value.absent(),
    this.receivedAt = const Value.absent(),
  });
  InboxQueueCompanion.insert({
    this.id = const Value.absent(),
    required String sender,
    required String body,
    required int receivedAt,
  }) : sender = Value(sender),
       body = Value(body),
       receivedAt = Value(receivedAt);
  static Insertable<InboxQueueRow> custom({
    Expression<int>? id,
    Expression<String>? sender,
    Expression<String>? body,
    Expression<int>? receivedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sender != null) 'sender': sender,
      if (body != null) 'body': body,
      if (receivedAt != null) 'received_at': receivedAt,
    });
  }

  InboxQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? sender,
    Value<String>? body,
    Value<int>? receivedAt,
  }) {
    return InboxQueueCompanion(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      body: body ?? this.body,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<int>(receivedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InboxQueueCompanion(')
          ..write('id: $id, ')
          ..write('sender: $sender, ')
          ..write('body: $body, ')
          ..write('receivedAt: $receivedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $CategoryRulesTable categoryRules = $CategoryRulesTable(this);
  late final $SenderAllowlistTable senderAllowlist = $SenderAllowlistTable(
    this,
  );
  late final $SyncStatesTable syncStates = $SyncStatesTable(this);
  late final $InboxQueueTable inboxQueue = $InboxQueueTable(this);
  late final Index indexTransactionsMessageHash = Index(
    'index_transactions_message_hash',
    'CREATE UNIQUE INDEX index_transactions_message_hash ON transactions (message_hash)',
  );
  late final Index indexTransactionsTxnTimestamp = Index(
    'index_transactions_txn_timestamp',
    'CREATE INDEX index_transactions_txn_timestamp ON transactions (txn_timestamp)',
  );
  late final Index indexCategoryRulesKeyword = Index(
    'index_category_rules_keyword',
    'CREATE UNIQUE INDEX index_category_rules_keyword ON category_rules (keyword)',
  );
  late final Index indexSenderAllowlistName = Index(
    'index_sender_allowlist_name',
    'CREATE UNIQUE INDEX index_sender_allowlist_name ON sender_allowlist (name)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    transactions,
    categoryRules,
    senderAllowlist,
    syncStates,
    inboxQueue,
    indexTransactionsMessageHash,
    indexTransactionsTxnTimestamp,
    indexCategoryRulesKeyword,
    indexSenderAllowlistName,
  ];
}

typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      required int amountPaise,
      required String type,
      required String source,
      Value<String?> merchant,
      Value<String> category,
      required int txnTimestamp,
      required bool isManual,
      Value<String?> rawSmsBody,
      Value<String?> sender,
      Value<String?> messageHash,
      required int createdAt,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<int> amountPaise,
      Value<String> type,
      Value<String> source,
      Value<String?> merchant,
      Value<String> category,
      Value<int> txnTimestamp,
      Value<bool> isManual,
      Value<String?> rawSmsBody,
      Value<String?> sender,
      Value<String?> messageHash,
      Value<int> createdAt,
    });

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get txnTimestamp => $composableBuilder(
    column: $table.txnTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isManual => $composableBuilder(
    column: $table.isManual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawSmsBody => $composableBuilder(
    column: $table.rawSmsBody,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageHash => $composableBuilder(
    column: $table.messageHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get txnTimestamp => $composableBuilder(
    column: $table.txnTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isManual => $composableBuilder(
    column: $table.isManual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawSmsBody => $composableBuilder(
    column: $table.rawSmsBody,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageHash => $composableBuilder(
    column: $table.messageHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get merchant =>
      $composableBuilder(column: $table.merchant, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get txnTimestamp => $composableBuilder(
    column: $table.txnTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isManual =>
      $composableBuilder(column: $table.isManual, builder: (column) => column);

  GeneratedColumn<String> get rawSmsBody => $composableBuilder(
    column: $table.rawSmsBody,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<String> get messageHash => $composableBuilder(
    column: $table.messageHash,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          TransactionRow,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (
            TransactionRow,
            BaseReferences<_$AppDatabase, $TransactionsTable, TransactionRow>,
          ),
          TransactionRow,
          PrefetchHooks Function()
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> amountPaise = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> merchant = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> txnTimestamp = const Value.absent(),
                Value<bool> isManual = const Value.absent(),
                Value<String?> rawSmsBody = const Value.absent(),
                Value<String?> sender = const Value.absent(),
                Value<String?> messageHash = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                amountPaise: amountPaise,
                type: type,
                source: source,
                merchant: merchant,
                category: category,
                txnTimestamp: txnTimestamp,
                isManual: isManual,
                rawSmsBody: rawSmsBody,
                sender: sender,
                messageHash: messageHash,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int amountPaise,
                required String type,
                required String source,
                Value<String?> merchant = const Value.absent(),
                Value<String> category = const Value.absent(),
                required int txnTimestamp,
                required bool isManual,
                Value<String?> rawSmsBody = const Value.absent(),
                Value<String?> sender = const Value.absent(),
                Value<String?> messageHash = const Value.absent(),
                required int createdAt,
              }) => TransactionsCompanion.insert(
                id: id,
                amountPaise: amountPaise,
                type: type,
                source: source,
                merchant: merchant,
                category: category,
                txnTimestamp: txnTimestamp,
                isManual: isManual,
                rawSmsBody: rawSmsBody,
                sender: sender,
                messageHash: messageHash,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTable, TransactionRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TransactionsTable,
                    TransactionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      TransactionRow,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (
        TransactionRow,
        BaseReferences<_$AppDatabase, $TransactionsTable, TransactionRow>,
      ),
      TransactionRow,
      PrefetchHooks Function()
    >;
typedef $$CategoryRulesTableCreateCompanionBuilder =
    CategoryRulesCompanion Function({
      Value<int> id,
      required String keyword,
      required String category,
      Value<int> priority,
    });
typedef $$CategoryRulesTableUpdateCompanionBuilder =
    CategoryRulesCompanion Function({
      Value<int> id,
      Value<String> keyword,
      Value<String> category,
      Value<int> priority,
    });

class $$CategoryRulesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryRulesTable> {
  $$CategoryRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyword => $composableBuilder(
    column: $table.keyword,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoryRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryRulesTable> {
  $$CategoryRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyword => $composableBuilder(
    column: $table.keyword,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoryRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryRulesTable> {
  $$CategoryRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get keyword =>
      $composableBuilder(column: $table.keyword, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);
}

class $$CategoryRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryRulesTable,
          CategoryRuleRow,
          $$CategoryRulesTableFilterComposer,
          $$CategoryRulesTableOrderingComposer,
          $$CategoryRulesTableAnnotationComposer,
          $$CategoryRulesTableCreateCompanionBuilder,
          $$CategoryRulesTableUpdateCompanionBuilder,
          (
            CategoryRuleRow,
            BaseReferences<_$AppDatabase, $CategoryRulesTable, CategoryRuleRow>,
          ),
          CategoryRuleRow,
          PrefetchHooks Function()
        > {
  $$CategoryRulesTableTableManager(_$AppDatabase db, $CategoryRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> keyword = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> priority = const Value.absent(),
              }) => CategoryRulesCompanion(
                id: id,
                keyword: keyword,
                category: category,
                priority: priority,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String keyword,
                required String category,
                Value<int> priority = const Value.absent(),
              }) => CategoryRulesCompanion.insert(
                id: id,
                keyword: keyword,
                category: category,
                priority: priority,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoryRulesTable, CategoryRuleRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CategoryRulesTable,
                    CategoryRuleRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoryRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryRulesTable,
      CategoryRuleRow,
      $$CategoryRulesTableFilterComposer,
      $$CategoryRulesTableOrderingComposer,
      $$CategoryRulesTableAnnotationComposer,
      $$CategoryRulesTableCreateCompanionBuilder,
      $$CategoryRulesTableUpdateCompanionBuilder,
      (
        CategoryRuleRow,
        BaseReferences<_$AppDatabase, $CategoryRulesTable, CategoryRuleRow>,
      ),
      CategoryRuleRow,
      PrefetchHooks Function()
    >;
typedef $$SenderAllowlistTableCreateCompanionBuilder =
    SenderAllowlistCompanion Function({
      Value<int> id,
      required String name,
      Value<bool> enabled,
    });
typedef $$SenderAllowlistTableUpdateCompanionBuilder =
    SenderAllowlistCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<bool> enabled,
    });

class $$SenderAllowlistTableFilterComposer
    extends Composer<_$AppDatabase, $SenderAllowlistTable> {
  $$SenderAllowlistTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SenderAllowlistTableOrderingComposer
    extends Composer<_$AppDatabase, $SenderAllowlistTable> {
  $$SenderAllowlistTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SenderAllowlistTableAnnotationComposer
    extends Composer<_$AppDatabase, $SenderAllowlistTable> {
  $$SenderAllowlistTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$SenderAllowlistTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SenderAllowlistTable,
          SenderAllowlistRow,
          $$SenderAllowlistTableFilterComposer,
          $$SenderAllowlistTableOrderingComposer,
          $$SenderAllowlistTableAnnotationComposer,
          $$SenderAllowlistTableCreateCompanionBuilder,
          $$SenderAllowlistTableUpdateCompanionBuilder,
          (
            SenderAllowlistRow,
            BaseReferences<
              _$AppDatabase,
              $SenderAllowlistTable,
              SenderAllowlistRow
            >,
          ),
          SenderAllowlistRow,
          PrefetchHooks Function()
        > {
  $$SenderAllowlistTableTableManager(
    _$AppDatabase db,
    $SenderAllowlistTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SenderAllowlistTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SenderAllowlistTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SenderAllowlistTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> enabled = const Value.absent(),
          }) => SenderAllowlistCompanion(id: id, name: name, enabled: enabled),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<bool> enabled = const Value.absent(),
              }) => SenderAllowlistCompanion.insert(
                id: id,
                name: name,
                enabled: enabled,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SenderAllowlistTable, SenderAllowlistRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SenderAllowlistTable,
                    SenderAllowlistRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SenderAllowlistTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SenderAllowlistTable,
      SenderAllowlistRow,
      $$SenderAllowlistTableFilterComposer,
      $$SenderAllowlistTableOrderingComposer,
      $$SenderAllowlistTableAnnotationComposer,
      $$SenderAllowlistTableCreateCompanionBuilder,
      $$SenderAllowlistTableUpdateCompanionBuilder,
      (
        SenderAllowlistRow,
        BaseReferences<
          _$AppDatabase,
          $SenderAllowlistTable,
          SenderAllowlistRow
        >,
      ),
      SenderAllowlistRow,
      PrefetchHooks Function()
    >;
typedef $$SyncStatesTableCreateCompanionBuilder = SyncStatesCompanion Function({
  Value<int> id,
  Value<int?> lastSyncedAt,
  Value<int> firstRunWindowDays,
});
typedef $$SyncStatesTableUpdateCompanionBuilder = SyncStatesCompanion Function({
  Value<int> id,
  Value<int?> lastSyncedAt,
  Value<int> firstRunWindowDays,
});

class $$SyncStatesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get firstRunWindowDays => $composableBuilder(
    column: $table.firstRunWindowDays,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get firstRunWindowDays => $composableBuilder(
    column: $table.firstRunWindowDays,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get firstRunWindowDays => $composableBuilder(
    column: $table.firstRunWindowDays,
    builder: (column) => column,
  );
}

class $$SyncStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncStatesTable,
          SyncStateRow,
          $$SyncStatesTableFilterComposer,
          $$SyncStatesTableOrderingComposer,
          $$SyncStatesTableAnnotationComposer,
          $$SyncStatesTableCreateCompanionBuilder,
          $$SyncStatesTableUpdateCompanionBuilder,
          (
            SyncStateRow,
            BaseReferences<_$AppDatabase, $SyncStatesTable, SyncStateRow>,
          ),
          SyncStateRow,
          PrefetchHooks Function()
        > {
  $$SyncStatesTableTableManager(_$AppDatabase db, $SyncStatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> lastSyncedAt = const Value.absent(),
                Value<int> firstRunWindowDays = const Value.absent(),
              }) => SyncStatesCompanion(
                id: id,
                lastSyncedAt: lastSyncedAt,
                firstRunWindowDays: firstRunWindowDays,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> lastSyncedAt = const Value.absent(),
                Value<int> firstRunWindowDays = const Value.absent(),
              }) => SyncStatesCompanion.insert(
                id: id,
                lastSyncedAt: lastSyncedAt,
                firstRunWindowDays: firstRunWindowDays,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncStatesTable, SyncStateRow>(table),
                  BaseReferences<_$AppDatabase, $SyncStatesTable, SyncStateRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncStatesTable,
      SyncStateRow,
      $$SyncStatesTableFilterComposer,
      $$SyncStatesTableOrderingComposer,
      $$SyncStatesTableAnnotationComposer,
      $$SyncStatesTableCreateCompanionBuilder,
      $$SyncStatesTableUpdateCompanionBuilder,
      (
        SyncStateRow,
        BaseReferences<_$AppDatabase, $SyncStatesTable, SyncStateRow>,
      ),
      SyncStateRow,
      PrefetchHooks Function()
    >;
typedef $$InboxQueueTableCreateCompanionBuilder = InboxQueueCompanion Function({
  Value<int> id,
  required String sender,
  required String body,
  required int receivedAt,
});
typedef $$InboxQueueTableUpdateCompanionBuilder = InboxQueueCompanion Function({
  Value<int> id,
  Value<String> sender,
  Value<String> body,
  Value<int> receivedAt,
});

class $$InboxQueueTableFilterComposer
    extends Composer<_$AppDatabase, $InboxQueueTable> {
  $$InboxQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InboxQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $InboxQueueTable> {
  $$InboxQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InboxQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $InboxQueueTable> {
  $$InboxQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );
}

class $$InboxQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InboxQueueTable,
          InboxQueueRow,
          $$InboxQueueTableFilterComposer,
          $$InboxQueueTableOrderingComposer,
          $$InboxQueueTableAnnotationComposer,
          $$InboxQueueTableCreateCompanionBuilder,
          $$InboxQueueTableUpdateCompanionBuilder,
          (
            InboxQueueRow,
            BaseReferences<_$AppDatabase, $InboxQueueTable, InboxQueueRow>,
          ),
          InboxQueueRow,
          PrefetchHooks Function()
        > {
  $$InboxQueueTableTableManager(_$AppDatabase db, $InboxQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InboxQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InboxQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InboxQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sender = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<int> receivedAt = const Value.absent(),
              }) => InboxQueueCompanion(
                id: id,
                sender: sender,
                body: body,
                receivedAt: receivedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sender,
                required String body,
                required int receivedAt,
              }) => InboxQueueCompanion.insert(
                id: id,
                sender: sender,
                body: body,
                receivedAt: receivedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InboxQueueTable, InboxQueueRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $InboxQueueTable,
                    InboxQueueRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InboxQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InboxQueueTable,
      InboxQueueRow,
      $$InboxQueueTableFilterComposer,
      $$InboxQueueTableOrderingComposer,
      $$InboxQueueTableAnnotationComposer,
      $$InboxQueueTableCreateCompanionBuilder,
      $$InboxQueueTableUpdateCompanionBuilder,
      (
        InboxQueueRow,
        BaseReferences<_$AppDatabase, $InboxQueueTable, InboxQueueRow>,
      ),
      InboxQueueRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$CategoryRulesTableTableManager get categoryRules =>
      $$CategoryRulesTableTableManager(_db, _db.categoryRules);
  $$SenderAllowlistTableTableManager get senderAllowlist =>
      $$SenderAllowlistTableTableManager(_db, _db.senderAllowlist);
  $$SyncStatesTableTableManager get syncStates =>
      $$SyncStatesTableTableManager(_db, _db.syncStates);
  $$InboxQueueTableTableManager get inboxQueue =>
      $$InboxQueueTableTableManager(_db, _db.inboxQueue);
}
