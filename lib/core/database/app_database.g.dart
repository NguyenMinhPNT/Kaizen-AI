// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconCodeMeta =
      const VerificationMeta('iconCode');
  @override
  late final GeneratedColumn<int> iconCode = GeneratedColumn<int>(
      'icon_code', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#4CAF50'));
  static const VerificationMeta _currentDurationMinutesMeta =
      const VerificationMeta('currentDurationMinutes');
  @override
  late final GeneratedColumn<int> currentDurationMinutes = GeneratedColumn<int>(
      'current_duration_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(10));
  static const VerificationMeta _maxDurationMinutesMeta =
      const VerificationMeta('maxDurationMinutes');
  @override
  late final GeneratedColumn<int> maxDurationMinutes = GeneratedColumn<int>(
      'max_duration_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(120));
  static const VerificationMeta _incrementMinutesMeta =
      const VerificationMeta('incrementMinutes');
  @override
  late final GeneratedColumn<int> incrementMinutes = GeneratedColumn<int>(
      'increment_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _treeTypeMeta =
      const VerificationMeta('treeType');
  @override
  late final GeneratedColumn<String> treeType = GeneratedColumn<String>(
      'tree_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('oak'));
  static const VerificationMeta _levelUpModeMeta =
      const VerificationMeta('levelUpMode');
  @override
  late final GeneratedColumn<String> levelUpMode = GeneratedColumn<String>(
      'level_up_mode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('manual'));
  static const VerificationMeta _currentStreakMeta =
      const VerificationMeta('currentStreak');
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
      'current_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _longestStreakMeta =
      const VerificationMeta('longestStreak');
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
      'longest_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalCompletedDaysMeta =
      const VerificationMeta('totalCompletedDays');
  @override
  late final GeneratedColumn<int> totalCompletedDays = GeneratedColumn<int>(
      'total_completed_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        iconCode,
        colorHex,
        currentDurationMinutes,
        maxDurationMinutes,
        incrementMinutes,
        treeType,
        levelUpMode,
        currentStreak,
        longestStreak,
        totalCompletedDays,
        isArchived,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(Insertable<Habit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('icon_code')) {
      context.handle(_iconCodeMeta,
          iconCode.isAcceptableOrUnknown(data['icon_code']!, _iconCodeMeta));
    } else if (isInserting) {
      context.missing(_iconCodeMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('current_duration_minutes')) {
      context.handle(
          _currentDurationMinutesMeta,
          currentDurationMinutes.isAcceptableOrUnknown(
              data['current_duration_minutes']!, _currentDurationMinutesMeta));
    }
    if (data.containsKey('max_duration_minutes')) {
      context.handle(
          _maxDurationMinutesMeta,
          maxDurationMinutes.isAcceptableOrUnknown(
              data['max_duration_minutes']!, _maxDurationMinutesMeta));
    }
    if (data.containsKey('increment_minutes')) {
      context.handle(
          _incrementMinutesMeta,
          incrementMinutes.isAcceptableOrUnknown(
              data['increment_minutes']!, _incrementMinutesMeta));
    }
    if (data.containsKey('tree_type')) {
      context.handle(_treeTypeMeta,
          treeType.isAcceptableOrUnknown(data['tree_type']!, _treeTypeMeta));
    }
    if (data.containsKey('level_up_mode')) {
      context.handle(
          _levelUpModeMeta,
          levelUpMode.isAcceptableOrUnknown(
              data['level_up_mode']!, _levelUpModeMeta));
    }
    if (data.containsKey('current_streak')) {
      context.handle(
          _currentStreakMeta,
          currentStreak.isAcceptableOrUnknown(
              data['current_streak']!, _currentStreakMeta));
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
          _longestStreakMeta,
          longestStreak.isAcceptableOrUnknown(
              data['longest_streak']!, _longestStreakMeta));
    }
    if (data.containsKey('total_completed_days')) {
      context.handle(
          _totalCompletedDaysMeta,
          totalCompletedDays.isAcceptableOrUnknown(
              data['total_completed_days']!, _totalCompletedDaysMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      iconCode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon_code'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      currentDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}current_duration_minutes'])!,
      maxDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}max_duration_minutes'])!,
      incrementMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}increment_minutes'])!,
      treeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tree_type'])!,
      levelUpMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}level_up_mode'])!,
      currentStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_streak'])!,
      longestStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}longest_streak'])!,
      totalCompletedDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_completed_days'])!,
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final String name;
  final String? description;
  final int iconCode;
  final String colorHex;
  final int currentDurationMinutes;
  final int maxDurationMinutes;
  final int incrementMinutes;
  final String treeType;
  final String levelUpMode;
  final int currentStreak;
  final int longestStreak;
  final int totalCompletedDays;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Habit(
      {required this.id,
      required this.name,
      this.description,
      required this.iconCode,
      required this.colorHex,
      required this.currentDurationMinutes,
      required this.maxDurationMinutes,
      required this.incrementMinutes,
      required this.treeType,
      required this.levelUpMode,
      required this.currentStreak,
      required this.longestStreak,
      required this.totalCompletedDays,
      required this.isArchived,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['icon_code'] = Variable<int>(iconCode);
    map['color_hex'] = Variable<String>(colorHex);
    map['current_duration_minutes'] = Variable<int>(currentDurationMinutes);
    map['max_duration_minutes'] = Variable<int>(maxDurationMinutes);
    map['increment_minutes'] = Variable<int>(incrementMinutes);
    map['tree_type'] = Variable<String>(treeType);
    map['level_up_mode'] = Variable<String>(levelUpMode);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    map['total_completed_days'] = Variable<int>(totalCompletedDays);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      iconCode: Value(iconCode),
      colorHex: Value(colorHex),
      currentDurationMinutes: Value(currentDurationMinutes),
      maxDurationMinutes: Value(maxDurationMinutes),
      incrementMinutes: Value(incrementMinutes),
      treeType: Value(treeType),
      levelUpMode: Value(levelUpMode),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      totalCompletedDays: Value(totalCompletedDays),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      iconCode: serializer.fromJson<int>(json['iconCode']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      currentDurationMinutes:
          serializer.fromJson<int>(json['currentDurationMinutes']),
      maxDurationMinutes: serializer.fromJson<int>(json['maxDurationMinutes']),
      incrementMinutes: serializer.fromJson<int>(json['incrementMinutes']),
      treeType: serializer.fromJson<String>(json['treeType']),
      levelUpMode: serializer.fromJson<String>(json['levelUpMode']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      totalCompletedDays: serializer.fromJson<int>(json['totalCompletedDays']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'iconCode': serializer.toJson<int>(iconCode),
      'colorHex': serializer.toJson<String>(colorHex),
      'currentDurationMinutes': serializer.toJson<int>(currentDurationMinutes),
      'maxDurationMinutes': serializer.toJson<int>(maxDurationMinutes),
      'incrementMinutes': serializer.toJson<int>(incrementMinutes),
      'treeType': serializer.toJson<String>(treeType),
      'levelUpMode': serializer.toJson<String>(levelUpMode),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'totalCompletedDays': serializer.toJson<int>(totalCompletedDays),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Habit copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          int? iconCode,
          String? colorHex,
          int? currentDurationMinutes,
          int? maxDurationMinutes,
          int? incrementMinutes,
          String? treeType,
          String? levelUpMode,
          int? currentStreak,
          int? longestStreak,
          int? totalCompletedDays,
          bool? isArchived,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Habit(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        iconCode: iconCode ?? this.iconCode,
        colorHex: colorHex ?? this.colorHex,
        currentDurationMinutes:
            currentDurationMinutes ?? this.currentDurationMinutes,
        maxDurationMinutes: maxDurationMinutes ?? this.maxDurationMinutes,
        incrementMinutes: incrementMinutes ?? this.incrementMinutes,
        treeType: treeType ?? this.treeType,
        levelUpMode: levelUpMode ?? this.levelUpMode,
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak,
        totalCompletedDays: totalCompletedDays ?? this.totalCompletedDays,
        isArchived: isArchived ?? this.isArchived,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      iconCode: data.iconCode.present ? data.iconCode.value : this.iconCode,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      currentDurationMinutes: data.currentDurationMinutes.present
          ? data.currentDurationMinutes.value
          : this.currentDurationMinutes,
      maxDurationMinutes: data.maxDurationMinutes.present
          ? data.maxDurationMinutes.value
          : this.maxDurationMinutes,
      incrementMinutes: data.incrementMinutes.present
          ? data.incrementMinutes.value
          : this.incrementMinutes,
      treeType: data.treeType.present ? data.treeType.value : this.treeType,
      levelUpMode:
          data.levelUpMode.present ? data.levelUpMode.value : this.levelUpMode,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      totalCompletedDays: data.totalCompletedDays.present
          ? data.totalCompletedDays.value
          : this.totalCompletedDays,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconCode: $iconCode, ')
          ..write('colorHex: $colorHex, ')
          ..write('currentDurationMinutes: $currentDurationMinutes, ')
          ..write('maxDurationMinutes: $maxDurationMinutes, ')
          ..write('incrementMinutes: $incrementMinutes, ')
          ..write('treeType: $treeType, ')
          ..write('levelUpMode: $levelUpMode, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('totalCompletedDays: $totalCompletedDays, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      description,
      iconCode,
      colorHex,
      currentDurationMinutes,
      maxDurationMinutes,
      incrementMinutes,
      treeType,
      levelUpMode,
      currentStreak,
      longestStreak,
      totalCompletedDays,
      isArchived,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.iconCode == this.iconCode &&
          other.colorHex == this.colorHex &&
          other.currentDurationMinutes == this.currentDurationMinutes &&
          other.maxDurationMinutes == this.maxDurationMinutes &&
          other.incrementMinutes == this.incrementMinutes &&
          other.treeType == this.treeType &&
          other.levelUpMode == this.levelUpMode &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.totalCompletedDays == this.totalCompletedDays &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> iconCode;
  final Value<String> colorHex;
  final Value<int> currentDurationMinutes;
  final Value<int> maxDurationMinutes;
  final Value<int> incrementMinutes;
  final Value<String> treeType;
  final Value<String> levelUpMode;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<int> totalCompletedDays;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.iconCode = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.currentDurationMinutes = const Value.absent(),
    this.maxDurationMinutes = const Value.absent(),
    this.incrementMinutes = const Value.absent(),
    this.treeType = const Value.absent(),
    this.levelUpMode = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.totalCompletedDays = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required int iconCode,
    this.colorHex = const Value.absent(),
    this.currentDurationMinutes = const Value.absent(),
    this.maxDurationMinutes = const Value.absent(),
    this.incrementMinutes = const Value.absent(),
    this.treeType = const Value.absent(),
    this.levelUpMode = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.totalCompletedDays = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        iconCode = Value(iconCode);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? iconCode,
    Expression<String>? colorHex,
    Expression<int>? currentDurationMinutes,
    Expression<int>? maxDurationMinutes,
    Expression<int>? incrementMinutes,
    Expression<String>? treeType,
    Expression<String>? levelUpMode,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<int>? totalCompletedDays,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (iconCode != null) 'icon_code': iconCode,
      if (colorHex != null) 'color_hex': colorHex,
      if (currentDurationMinutes != null)
        'current_duration_minutes': currentDurationMinutes,
      if (maxDurationMinutes != null)
        'max_duration_minutes': maxDurationMinutes,
      if (incrementMinutes != null) 'increment_minutes': incrementMinutes,
      if (treeType != null) 'tree_type': treeType,
      if (levelUpMode != null) 'level_up_mode': levelUpMode,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (totalCompletedDays != null)
        'total_completed_days': totalCompletedDays,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HabitsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<int>? iconCode,
      Value<String>? colorHex,
      Value<int>? currentDurationMinutes,
      Value<int>? maxDurationMinutes,
      Value<int>? incrementMinutes,
      Value<String>? treeType,
      Value<String>? levelUpMode,
      Value<int>? currentStreak,
      Value<int>? longestStreak,
      Value<int>? totalCompletedDays,
      Value<bool>? isArchived,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconCode: iconCode ?? this.iconCode,
      colorHex: colorHex ?? this.colorHex,
      currentDurationMinutes:
          currentDurationMinutes ?? this.currentDurationMinutes,
      maxDurationMinutes: maxDurationMinutes ?? this.maxDurationMinutes,
      incrementMinutes: incrementMinutes ?? this.incrementMinutes,
      treeType: treeType ?? this.treeType,
      levelUpMode: levelUpMode ?? this.levelUpMode,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalCompletedDays: totalCompletedDays ?? this.totalCompletedDays,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (iconCode.present) {
      map['icon_code'] = Variable<int>(iconCode.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (currentDurationMinutes.present) {
      map['current_duration_minutes'] =
          Variable<int>(currentDurationMinutes.value);
    }
    if (maxDurationMinutes.present) {
      map['max_duration_minutes'] = Variable<int>(maxDurationMinutes.value);
    }
    if (incrementMinutes.present) {
      map['increment_minutes'] = Variable<int>(incrementMinutes.value);
    }
    if (treeType.present) {
      map['tree_type'] = Variable<String>(treeType.value);
    }
    if (levelUpMode.present) {
      map['level_up_mode'] = Variable<String>(levelUpMode.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (totalCompletedDays.present) {
      map['total_completed_days'] = Variable<int>(totalCompletedDays.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconCode: $iconCode, ')
          ..write('colorHex: $colorHex, ')
          ..write('currentDurationMinutes: $currentDurationMinutes, ')
          ..write('maxDurationMinutes: $maxDurationMinutes, ')
          ..write('incrementMinutes: $incrementMinutes, ')
          ..write('treeType: $treeType, ')
          ..write('levelUpMode: $levelUpMode, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('totalCompletedDays: $totalCompletedDays, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HabitLogsTable extends HabitLogs
    with TableInfo<$HabitLogsTable, HabitLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _habitIdMeta =
      const VerificationMeta('habitId');
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
      'habit_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES habits (id)'));
  static const VerificationMeta _logDateMeta =
      const VerificationMeta('logDate');
  @override
  late final GeneratedColumn<DateTime> logDate = GeneratedColumn<DateTime>(
      'log_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _targetDurationMinutesMeta =
      const VerificationMeta('targetDurationMinutes');
  @override
  late final GeneratedColumn<int> targetDurationMinutes = GeneratedColumn<int>(
      'target_duration_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _actualDurationMinutesMeta =
      const VerificationMeta('actualDurationMinutes');
  @override
  late final GeneratedColumn<int> actualDurationMinutes = GeneratedColumn<int>(
      'actual_duration_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('skipped'));
  static const VerificationMeta _completionPercentageMeta =
      const VerificationMeta('completionPercentage');
  @override
  late final GeneratedColumn<double> completionPercentage =
      GeneratedColumn<double>('completion_percentage', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        habitId,
        logDate,
        targetDurationMinutes,
        actualDurationMinutes,
        status,
        completionPercentage,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_logs';
  @override
  VerificationContext validateIntegrity(Insertable<HabitLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta));
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('log_date')) {
      context.handle(_logDateMeta,
          logDate.isAcceptableOrUnknown(data['log_date']!, _logDateMeta));
    } else if (isInserting) {
      context.missing(_logDateMeta);
    }
    if (data.containsKey('target_duration_minutes')) {
      context.handle(
          _targetDurationMinutesMeta,
          targetDurationMinutes.isAcceptableOrUnknown(
              data['target_duration_minutes']!, _targetDurationMinutesMeta));
    } else if (isInserting) {
      context.missing(_targetDurationMinutesMeta);
    }
    if (data.containsKey('actual_duration_minutes')) {
      context.handle(
          _actualDurationMinutesMeta,
          actualDurationMinutes.isAcceptableOrUnknown(
              data['actual_duration_minutes']!, _actualDurationMinutesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('completion_percentage')) {
      context.handle(
          _completionPercentageMeta,
          completionPercentage.isAcceptableOrUnknown(
              data['completion_percentage']!, _completionPercentageMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {habitId, logDate},
      ];
  @override
  HabitLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      habitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}habit_id'])!,
      logDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}log_date'])!,
      targetDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}target_duration_minutes'])!,
      actualDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}actual_duration_minutes'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      completionPercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}completion_percentage'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HabitLogsTable createAlias(String alias) {
    return $HabitLogsTable(attachedDatabase, alias);
  }
}

class HabitLog extends DataClass implements Insertable<HabitLog> {
  final int id;
  final int habitId;
  final DateTime logDate;
  final int targetDurationMinutes;
  final int actualDurationMinutes;
  final String status;
  final double completionPercentage;
  final DateTime createdAt;
  const HabitLog(
      {required this.id,
      required this.habitId,
      required this.logDate,
      required this.targetDurationMinutes,
      required this.actualDurationMinutes,
      required this.status,
      required this.completionPercentage,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['log_date'] = Variable<DateTime>(logDate);
    map['target_duration_minutes'] = Variable<int>(targetDurationMinutes);
    map['actual_duration_minutes'] = Variable<int>(actualDurationMinutes);
    map['status'] = Variable<String>(status);
    map['completion_percentage'] = Variable<double>(completionPercentage);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitLogsCompanion toCompanion(bool nullToAbsent) {
    return HabitLogsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      logDate: Value(logDate),
      targetDurationMinutes: Value(targetDurationMinutes),
      actualDurationMinutes: Value(actualDurationMinutes),
      status: Value(status),
      completionPercentage: Value(completionPercentage),
      createdAt: Value(createdAt),
    );
  }

  factory HabitLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitLog(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      logDate: serializer.fromJson<DateTime>(json['logDate']),
      targetDurationMinutes:
          serializer.fromJson<int>(json['targetDurationMinutes']),
      actualDurationMinutes:
          serializer.fromJson<int>(json['actualDurationMinutes']),
      status: serializer.fromJson<String>(json['status']),
      completionPercentage:
          serializer.fromJson<double>(json['completionPercentage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'logDate': serializer.toJson<DateTime>(logDate),
      'targetDurationMinutes': serializer.toJson<int>(targetDurationMinutes),
      'actualDurationMinutes': serializer.toJson<int>(actualDurationMinutes),
      'status': serializer.toJson<String>(status),
      'completionPercentage': serializer.toJson<double>(completionPercentage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HabitLog copyWith(
          {int? id,
          int? habitId,
          DateTime? logDate,
          int? targetDurationMinutes,
          int? actualDurationMinutes,
          String? status,
          double? completionPercentage,
          DateTime? createdAt}) =>
      HabitLog(
        id: id ?? this.id,
        habitId: habitId ?? this.habitId,
        logDate: logDate ?? this.logDate,
        targetDurationMinutes:
            targetDurationMinutes ?? this.targetDurationMinutes,
        actualDurationMinutes:
            actualDurationMinutes ?? this.actualDurationMinutes,
        status: status ?? this.status,
        completionPercentage: completionPercentage ?? this.completionPercentage,
        createdAt: createdAt ?? this.createdAt,
      );
  HabitLog copyWithCompanion(HabitLogsCompanion data) {
    return HabitLog(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      logDate: data.logDate.present ? data.logDate.value : this.logDate,
      targetDurationMinutes: data.targetDurationMinutes.present
          ? data.targetDurationMinutes.value
          : this.targetDurationMinutes,
      actualDurationMinutes: data.actualDurationMinutes.present
          ? data.actualDurationMinutes.value
          : this.actualDurationMinutes,
      status: data.status.present ? data.status.value : this.status,
      completionPercentage: data.completionPercentage.present
          ? data.completionPercentage.value
          : this.completionPercentage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitLog(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('logDate: $logDate, ')
          ..write('targetDurationMinutes: $targetDurationMinutes, ')
          ..write('actualDurationMinutes: $actualDurationMinutes, ')
          ..write('status: $status, ')
          ..write('completionPercentage: $completionPercentage, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitId, logDate, targetDurationMinutes,
      actualDurationMinutes, status, completionPercentage, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitLog &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.logDate == this.logDate &&
          other.targetDurationMinutes == this.targetDurationMinutes &&
          other.actualDurationMinutes == this.actualDurationMinutes &&
          other.status == this.status &&
          other.completionPercentage == this.completionPercentage &&
          other.createdAt == this.createdAt);
}

class HabitLogsCompanion extends UpdateCompanion<HabitLog> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<DateTime> logDate;
  final Value<int> targetDurationMinutes;
  final Value<int> actualDurationMinutes;
  final Value<String> status;
  final Value<double> completionPercentage;
  final Value<DateTime> createdAt;
  const HabitLogsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.logDate = const Value.absent(),
    this.targetDurationMinutes = const Value.absent(),
    this.actualDurationMinutes = const Value.absent(),
    this.status = const Value.absent(),
    this.completionPercentage = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HabitLogsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required DateTime logDate,
    required int targetDurationMinutes,
    this.actualDurationMinutes = const Value.absent(),
    this.status = const Value.absent(),
    this.completionPercentage = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : habitId = Value(habitId),
        logDate = Value(logDate),
        targetDurationMinutes = Value(targetDurationMinutes);
  static Insertable<HabitLog> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<DateTime>? logDate,
    Expression<int>? targetDurationMinutes,
    Expression<int>? actualDurationMinutes,
    Expression<String>? status,
    Expression<double>? completionPercentage,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (logDate != null) 'log_date': logDate,
      if (targetDurationMinutes != null)
        'target_duration_minutes': targetDurationMinutes,
      if (actualDurationMinutes != null)
        'actual_duration_minutes': actualDurationMinutes,
      if (status != null) 'status': status,
      if (completionPercentage != null)
        'completion_percentage': completionPercentage,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HabitLogsCompanion copyWith(
      {Value<int>? id,
      Value<int>? habitId,
      Value<DateTime>? logDate,
      Value<int>? targetDurationMinutes,
      Value<int>? actualDurationMinutes,
      Value<String>? status,
      Value<double>? completionPercentage,
      Value<DateTime>? createdAt}) {
    return HabitLogsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      logDate: logDate ?? this.logDate,
      targetDurationMinutes:
          targetDurationMinutes ?? this.targetDurationMinutes,
      actualDurationMinutes:
          actualDurationMinutes ?? this.actualDurationMinutes,
      status: status ?? this.status,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (logDate.present) {
      map['log_date'] = Variable<DateTime>(logDate.value);
    }
    if (targetDurationMinutes.present) {
      map['target_duration_minutes'] =
          Variable<int>(targetDurationMinutes.value);
    }
    if (actualDurationMinutes.present) {
      map['actual_duration_minutes'] =
          Variable<int>(actualDurationMinutes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (completionPercentage.present) {
      map['completion_percentage'] =
          Variable<double>(completionPercentage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('logDate: $logDate, ')
          ..write('targetDurationMinutes: $targetDurationMinutes, ')
          ..write('actualDurationMinutes: $actualDurationMinutes, ')
          ..write('status: $status, ')
          ..write('completionPercentage: $completionPercentage, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HabitTreesTable extends HabitTrees
    with TableInfo<$HabitTreesTable, HabitTree> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitTreesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _habitIdMeta =
      const VerificationMeta('habitId');
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
      'habit_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('UNIQUE REFERENCES habits (id)'));
  static const VerificationMeta _treeTypeMeta =
      const VerificationMeta('treeType');
  @override
  late final GeneratedColumn<String> treeType = GeneratedColumn<String>(
      'tree_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('oak'));
  static const VerificationMeta _currentStageMeta =
      const VerificationMeta('currentStage');
  @override
  late final GeneratedColumn<int> currentStage = GeneratedColumn<int>(
      'current_stage', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, habitId, treeType, currentStage, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_trees';
  @override
  VerificationContext validateIntegrity(Insertable<HabitTree> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta));
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('tree_type')) {
      context.handle(_treeTypeMeta,
          treeType.isAcceptableOrUnknown(data['tree_type']!, _treeTypeMeta));
    }
    if (data.containsKey('current_stage')) {
      context.handle(
          _currentStageMeta,
          currentStage.isAcceptableOrUnknown(
              data['current_stage']!, _currentStageMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitTree map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitTree(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      habitId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}habit_id'])!,
      treeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tree_type'])!,
      currentStage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_stage'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $HabitTreesTable createAlias(String alias) {
    return $HabitTreesTable(attachedDatabase, alias);
  }
}

class HabitTree extends DataClass implements Insertable<HabitTree> {
  final int id;
  final int habitId;
  final String treeType;
  final int currentStage;
  final DateTime createdAt;
  final DateTime updatedAt;
  const HabitTree(
      {required this.id,
      required this.habitId,
      required this.treeType,
      required this.currentStage,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['tree_type'] = Variable<String>(treeType);
    map['current_stage'] = Variable<int>(currentStage);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HabitTreesCompanion toCompanion(bool nullToAbsent) {
    return HabitTreesCompanion(
      id: Value(id),
      habitId: Value(habitId),
      treeType: Value(treeType),
      currentStage: Value(currentStage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HabitTree.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitTree(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      treeType: serializer.fromJson<String>(json['treeType']),
      currentStage: serializer.fromJson<int>(json['currentStage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'treeType': serializer.toJson<String>(treeType),
      'currentStage': serializer.toJson<int>(currentStage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HabitTree copyWith(
          {int? id,
          int? habitId,
          String? treeType,
          int? currentStage,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      HabitTree(
        id: id ?? this.id,
        habitId: habitId ?? this.habitId,
        treeType: treeType ?? this.treeType,
        currentStage: currentStage ?? this.currentStage,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  HabitTree copyWithCompanion(HabitTreesCompanion data) {
    return HabitTree(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      treeType: data.treeType.present ? data.treeType.value : this.treeType,
      currentStage: data.currentStage.present
          ? data.currentStage.value
          : this.currentStage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitTree(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('treeType: $treeType, ')
          ..write('currentStage: $currentStage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, habitId, treeType, currentStage, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitTree &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.treeType == this.treeType &&
          other.currentStage == this.currentStage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HabitTreesCompanion extends UpdateCompanion<HabitTree> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<String> treeType;
  final Value<int> currentStage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const HabitTreesCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.treeType = const Value.absent(),
    this.currentStage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HabitTreesCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    this.treeType = const Value.absent(),
    this.currentStage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : habitId = Value(habitId);
  static Insertable<HabitTree> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<String>? treeType,
    Expression<int>? currentStage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (treeType != null) 'tree_type': treeType,
      if (currentStage != null) 'current_stage': currentStage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HabitTreesCompanion copyWith(
      {Value<int>? id,
      Value<int>? habitId,
      Value<String>? treeType,
      Value<int>? currentStage,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return HabitTreesCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      treeType: treeType ?? this.treeType,
      currentStage: currentStage ?? this.currentStage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (treeType.present) {
      map['tree_type'] = Variable<String>(treeType.value);
    }
    if (currentStage.present) {
      map['current_stage'] = Variable<int>(currentStage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitTreesCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('treeType: $treeType, ')
          ..write('currentStage: $currentStage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitLogsTable habitLogs = $HabitLogsTable(this);
  late final $HabitTreesTable habitTrees = $HabitTreesTable(this);
  late final HabitDao habitDao = HabitDao(this as AppDatabase);
  late final HabitLogDao habitLogDao = HabitLogDao(this as AppDatabase);
  late final HabitTreeDao habitTreeDao = HabitTreeDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [habits, habitLogs, habitTrees];
}

typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  required int iconCode,
  Value<String> colorHex,
  Value<int> currentDurationMinutes,
  Value<int> maxDurationMinutes,
  Value<int> incrementMinutes,
  Value<String> treeType,
  Value<String> levelUpMode,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<int> totalCompletedDays,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<int> iconCode,
  Value<String> colorHex,
  Value<int> currentDurationMinutes,
  Value<int> maxDurationMinutes,
  Value<int> incrementMinutes,
  Value<String> treeType,
  Value<String> levelUpMode,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<int> totalCompletedDays,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitLogsTable, List<HabitLog>>
      _habitLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.habitLogs,
          aliasName: $_aliasNameGenerator(db.habits.id, db.habitLogs.habitId));

  $$HabitLogsTableProcessedTableManager get habitLogsRefs {
    final manager = $$HabitLogsTableTableManager($_db, $_db.habitLogs)
        .filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$HabitTreesTable, List<HabitTree>>
      _habitTreesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.habitTrees,
          aliasName: $_aliasNameGenerator(db.habits.id, db.habitTrees.habitId));

  $$HabitTreesTableProcessedTableManager get habitTreesRefs {
    final manager = $$HabitTreesTableTableManager($_db, $_db.habitTrees)
        .filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitTreesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get iconCode => $composableBuilder(
      column: $table.iconCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentDurationMinutes => $composableBuilder(
      column: $table.currentDurationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxDurationMinutes => $composableBuilder(
      column: $table.maxDurationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get incrementMinutes => $composableBuilder(
      column: $table.incrementMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get treeType => $composableBuilder(
      column: $table.treeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get levelUpMode => $composableBuilder(
      column: $table.levelUpMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalCompletedDays => $composableBuilder(
      column: $table.totalCompletedDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> habitLogsRefs(
      Expression<bool> Function($$HabitLogsTableFilterComposer f) f) {
    final $$HabitLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.habitLogs,
        getReferencedColumn: (t) => t.habitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitLogsTableFilterComposer(
              $db: $db,
              $table: $db.habitLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> habitTreesRefs(
      Expression<bool> Function($$HabitTreesTableFilterComposer f) f) {
    final $$HabitTreesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.habitTrees,
        getReferencedColumn: (t) => t.habitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitTreesTableFilterComposer(
              $db: $db,
              $table: $db.habitTrees,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get iconCode => $composableBuilder(
      column: $table.iconCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentDurationMinutes => $composableBuilder(
      column: $table.currentDurationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxDurationMinutes => $composableBuilder(
      column: $table.maxDurationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get incrementMinutes => $composableBuilder(
      column: $table.incrementMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get treeType => $composableBuilder(
      column: $table.treeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get levelUpMode => $composableBuilder(
      column: $table.levelUpMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalCompletedDays => $composableBuilder(
      column: $table.totalCompletedDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get iconCode =>
      $composableBuilder(column: $table.iconCode, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<int> get currentDurationMinutes => $composableBuilder(
      column: $table.currentDurationMinutes, builder: (column) => column);

  GeneratedColumn<int> get maxDurationMinutes => $composableBuilder(
      column: $table.maxDurationMinutes, builder: (column) => column);

  GeneratedColumn<int> get incrementMinutes => $composableBuilder(
      column: $table.incrementMinutes, builder: (column) => column);

  GeneratedColumn<String> get treeType =>
      $composableBuilder(column: $table.treeType, builder: (column) => column);

  GeneratedColumn<String> get levelUpMode => $composableBuilder(
      column: $table.levelUpMode, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => column);

  GeneratedColumn<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => column);

  GeneratedColumn<int> get totalCompletedDays => $composableBuilder(
      column: $table.totalCompletedDays, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> habitLogsRefs<T extends Object>(
      Expression<T> Function($$HabitLogsTableAnnotationComposer a) f) {
    final $$HabitLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.habitLogs,
        getReferencedColumn: (t) => t.habitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.habitLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> habitTreesRefs<T extends Object>(
      Expression<T> Function($$HabitTreesTableAnnotationComposer a) f) {
    final $$HabitTreesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.habitTrees,
        getReferencedColumn: (t) => t.habitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitTreesTableAnnotationComposer(
              $db: $db,
              $table: $db.habitTrees,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HabitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitsTable,
    Habit,
    $$HabitsTableFilterComposer,
    $$HabitsTableOrderingComposer,
    $$HabitsTableAnnotationComposer,
    $$HabitsTableCreateCompanionBuilder,
    $$HabitsTableUpdateCompanionBuilder,
    (Habit, $$HabitsTableReferences),
    Habit,
    PrefetchHooks Function({bool habitLogsRefs, bool habitTreesRefs})> {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> iconCode = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<int> currentDurationMinutes = const Value.absent(),
            Value<int> maxDurationMinutes = const Value.absent(),
            Value<int> incrementMinutes = const Value.absent(),
            Value<String> treeType = const Value.absent(),
            Value<String> levelUpMode = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<int> totalCompletedDays = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              HabitsCompanion(
            id: id,
            name: name,
            description: description,
            iconCode: iconCode,
            colorHex: colorHex,
            currentDurationMinutes: currentDurationMinutes,
            maxDurationMinutes: maxDurationMinutes,
            incrementMinutes: incrementMinutes,
            treeType: treeType,
            levelUpMode: levelUpMode,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            totalCompletedDays: totalCompletedDays,
            isArchived: isArchived,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            required int iconCode,
            Value<String> colorHex = const Value.absent(),
            Value<int> currentDurationMinutes = const Value.absent(),
            Value<int> maxDurationMinutes = const Value.absent(),
            Value<int> incrementMinutes = const Value.absent(),
            Value<String> treeType = const Value.absent(),
            Value<String> levelUpMode = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<int> totalCompletedDays = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              HabitsCompanion.insert(
            id: id,
            name: name,
            description: description,
            iconCode: iconCode,
            colorHex: colorHex,
            currentDurationMinutes: currentDurationMinutes,
            maxDurationMinutes: maxDurationMinutes,
            incrementMinutes: incrementMinutes,
            treeType: treeType,
            levelUpMode: levelUpMode,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            totalCompletedDays: totalCompletedDays,
            isArchived: isArchived,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$HabitsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {habitLogsRefs = false, habitTreesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (habitLogsRefs) db.habitLogs,
                if (habitTreesRefs) db.habitTrees
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitLogsRefs)
                    await $_getPrefetchedData<Habit, $HabitsTable, HabitLog>(
                        currentTable: table,
                        referencedTable:
                            $$HabitsTableReferences._habitLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$HabitsTableReferences(db, table, p0)
                                .habitLogsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.habitId == item.id),
                        typedResults: items),
                  if (habitTreesRefs)
                    await $_getPrefetchedData<Habit, $HabitsTable, HabitTree>(
                        currentTable: table,
                        referencedTable:
                            $$HabitsTableReferences._habitTreesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$HabitsTableReferences(db, table, p0)
                                .habitTreesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.habitId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$HabitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitsTable,
    Habit,
    $$HabitsTableFilterComposer,
    $$HabitsTableOrderingComposer,
    $$HabitsTableAnnotationComposer,
    $$HabitsTableCreateCompanionBuilder,
    $$HabitsTableUpdateCompanionBuilder,
    (Habit, $$HabitsTableReferences),
    Habit,
    PrefetchHooks Function({bool habitLogsRefs, bool habitTreesRefs})>;
typedef $$HabitLogsTableCreateCompanionBuilder = HabitLogsCompanion Function({
  Value<int> id,
  required int habitId,
  required DateTime logDate,
  required int targetDurationMinutes,
  Value<int> actualDurationMinutes,
  Value<String> status,
  Value<double> completionPercentage,
  Value<DateTime> createdAt,
});
typedef $$HabitLogsTableUpdateCompanionBuilder = HabitLogsCompanion Function({
  Value<int> id,
  Value<int> habitId,
  Value<DateTime> logDate,
  Value<int> targetDurationMinutes,
  Value<int> actualDurationMinutes,
  Value<String> status,
  Value<double> completionPercentage,
  Value<DateTime> createdAt,
});

final class $$HabitLogsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitLogsTable, HabitLog> {
  $$HabitLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits
      .createAlias($_aliasNameGenerator(db.habitLogs.habitId, db.habits.id));

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager($_db, $_db.habits)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$HabitLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get logDate => $composableBuilder(
      column: $table.logDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetDurationMinutes => $composableBuilder(
      column: $table.targetDurationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get actualDurationMinutes => $composableBuilder(
      column: $table.actualDurationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get completionPercentage => $composableBuilder(
      column: $table.completionPercentage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableFilterComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get logDate => $composableBuilder(
      column: $table.logDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetDurationMinutes => $composableBuilder(
      column: $table.targetDurationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get actualDurationMinutes => $composableBuilder(
      column: $table.actualDurationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get completionPercentage => $composableBuilder(
      column: $table.completionPercentage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableOrderingComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get logDate =>
      $composableBuilder(column: $table.logDate, builder: (column) => column);

  GeneratedColumn<int> get targetDurationMinutes => $composableBuilder(
      column: $table.targetDurationMinutes, builder: (column) => column);

  GeneratedColumn<int> get actualDurationMinutes => $composableBuilder(
      column: $table.actualDurationMinutes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get completionPercentage => $composableBuilder(
      column: $table.completionPercentage, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableAnnotationComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitLogsTable,
    HabitLog,
    $$HabitLogsTableFilterComposer,
    $$HabitLogsTableOrderingComposer,
    $$HabitLogsTableAnnotationComposer,
    $$HabitLogsTableCreateCompanionBuilder,
    $$HabitLogsTableUpdateCompanionBuilder,
    (HabitLog, $$HabitLogsTableReferences),
    HabitLog,
    PrefetchHooks Function({bool habitId})> {
  $$HabitLogsTableTableManager(_$AppDatabase db, $HabitLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> habitId = const Value.absent(),
            Value<DateTime> logDate = const Value.absent(),
            Value<int> targetDurationMinutes = const Value.absent(),
            Value<int> actualDurationMinutes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<double> completionPercentage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HabitLogsCompanion(
            id: id,
            habitId: habitId,
            logDate: logDate,
            targetDurationMinutes: targetDurationMinutes,
            actualDurationMinutes: actualDurationMinutes,
            status: status,
            completionPercentage: completionPercentage,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int habitId,
            required DateTime logDate,
            required int targetDurationMinutes,
            Value<int> actualDurationMinutes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<double> completionPercentage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HabitLogsCompanion.insert(
            id: id,
            habitId: habitId,
            logDate: logDate,
            targetDurationMinutes: targetDurationMinutes,
            actualDurationMinutes: actualDurationMinutes,
            status: status,
            completionPercentage: completionPercentage,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HabitLogsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (habitId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.habitId,
                    referencedTable:
                        $$HabitLogsTableReferences._habitIdTable(db),
                    referencedColumn:
                        $$HabitLogsTableReferences._habitIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$HabitLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitLogsTable,
    HabitLog,
    $$HabitLogsTableFilterComposer,
    $$HabitLogsTableOrderingComposer,
    $$HabitLogsTableAnnotationComposer,
    $$HabitLogsTableCreateCompanionBuilder,
    $$HabitLogsTableUpdateCompanionBuilder,
    (HabitLog, $$HabitLogsTableReferences),
    HabitLog,
    PrefetchHooks Function({bool habitId})>;
typedef $$HabitTreesTableCreateCompanionBuilder = HabitTreesCompanion Function({
  Value<int> id,
  required int habitId,
  Value<String> treeType,
  Value<int> currentStage,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$HabitTreesTableUpdateCompanionBuilder = HabitTreesCompanion Function({
  Value<int> id,
  Value<int> habitId,
  Value<String> treeType,
  Value<int> currentStage,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$HabitTreesTableReferences
    extends BaseReferences<_$AppDatabase, $HabitTreesTable, HabitTree> {
  $$HabitTreesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits
      .createAlias($_aliasNameGenerator(db.habitTrees.habitId, db.habits.id));

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager($_db, $_db.habits)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$HabitTreesTableFilterComposer
    extends Composer<_$AppDatabase, $HabitTreesTable> {
  $$HabitTreesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get treeType => $composableBuilder(
      column: $table.treeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentStage => $composableBuilder(
      column: $table.currentStage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableFilterComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitTreesTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitTreesTable> {
  $$HabitTreesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get treeType => $composableBuilder(
      column: $table.treeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentStage => $composableBuilder(
      column: $table.currentStage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableOrderingComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitTreesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitTreesTable> {
  $$HabitTreesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get treeType =>
      $composableBuilder(column: $table.treeType, builder: (column) => column);

  GeneratedColumn<int> get currentStage => $composableBuilder(
      column: $table.currentStage, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableAnnotationComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitTreesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitTreesTable,
    HabitTree,
    $$HabitTreesTableFilterComposer,
    $$HabitTreesTableOrderingComposer,
    $$HabitTreesTableAnnotationComposer,
    $$HabitTreesTableCreateCompanionBuilder,
    $$HabitTreesTableUpdateCompanionBuilder,
    (HabitTree, $$HabitTreesTableReferences),
    HabitTree,
    PrefetchHooks Function({bool habitId})> {
  $$HabitTreesTableTableManager(_$AppDatabase db, $HabitTreesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitTreesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitTreesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitTreesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> habitId = const Value.absent(),
            Value<String> treeType = const Value.absent(),
            Value<int> currentStage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              HabitTreesCompanion(
            id: id,
            habitId: habitId,
            treeType: treeType,
            currentStage: currentStage,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int habitId,
            Value<String> treeType = const Value.absent(),
            Value<int> currentStage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              HabitTreesCompanion.insert(
            id: id,
            habitId: habitId,
            treeType: treeType,
            currentStage: currentStage,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HabitTreesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (habitId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.habitId,
                    referencedTable:
                        $$HabitTreesTableReferences._habitIdTable(db),
                    referencedColumn:
                        $$HabitTreesTableReferences._habitIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$HabitTreesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitTreesTable,
    HabitTree,
    $$HabitTreesTableFilterComposer,
    $$HabitTreesTableOrderingComposer,
    $$HabitTreesTableAnnotationComposer,
    $$HabitTreesTableCreateCompanionBuilder,
    $$HabitTreesTableUpdateCompanionBuilder,
    (HabitTree, $$HabitTreesTableReferences),
    HabitTree,
    PrefetchHooks Function({bool habitId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitLogsTableTableManager get habitLogs =>
      $$HabitLogsTableTableManager(_db, _db.habitLogs);
  $$HabitTreesTableTableManager get habitTrees =>
      $$HabitTreesTableTableManager(_db, _db.habitTrees);
}
