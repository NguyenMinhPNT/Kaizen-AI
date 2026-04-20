import 'package:drift/drift.dart';

/// Habits table — stores each habit's configuration and progression state.
class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  IntColumn get iconCode => integer()();
  TextColumn get colorHex => text().withDefault(const Constant('#4CAF50'))();
  IntColumn get currentDurationMinutes =>
      integer().withDefault(const Constant(10))();
  IntColumn get maxDurationMinutes =>
      integer().withDefault(const Constant(120))();
  IntColumn get incrementMinutes => integer().withDefault(const Constant(5))();
  TextColumn get treeType => text().withDefault(const Constant('oak'))();
  TextColumn get levelUpMode => text().withDefault(const Constant('manual'))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  IntColumn get totalCompletedDays =>
      integer().withDefault(const Constant(0))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// HabitLogs table — one row per habit per day.
/// UNIQUE constraint: (habitId, logDate)
class HabitLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer().references(Habits, #id)();
  DateTimeColumn get logDate => dateTime()();
  IntColumn get targetDurationMinutes => integer()();
  IntColumn get actualDurationMinutes =>
      integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('skipped'))();
  RealColumn get completionPercentage =>
      real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
        {habitId, logDate},
      ];
}

/// HabitTrees table — 1:1 with habits (each habit grows one tree).
class HabitTrees extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer().references(Habits, #id).unique()();
  TextColumn get treeType => text().withDefault(const Constant('oak'))();
  IntColumn get currentStage => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
