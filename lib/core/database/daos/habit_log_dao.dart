import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables.dart';

part 'habit_log_dao.g.dart';

@DriftAccessor(tables: [HabitLogs])
class HabitLogDao extends DatabaseAccessor<AppDatabase>
    with _$HabitLogDaoMixin {
  HabitLogDao(super.db);

  /// Returns all logs for a habit sorted by date descending.
  Future<List<HabitLog>> getLogsForHabit(int habitId) => (select(habitLogs)
        ..where((l) => l.habitId.equals(habitId))
        ..orderBy([(l) => OrderingTerm.desc(l.logDate)]))
      .get();

  /// Returns logs for a habit within a date range.
  Future<List<HabitLog>> getLogsForHabitInRange(
    int habitId,
    DateTime start,
    DateTime end,
  ) =>
      (select(habitLogs)
            ..where(
              (l) =>
                  l.habitId.equals(habitId) &
                  l.logDate.isBetweenValues(start, end),
            )
            ..orderBy([(l) => OrderingTerm.asc(l.logDate)]))
          .get();

  /// Returns the log for a specific habit on a specific date, or null.
  Future<HabitLog?> getLogForHabitOnDate(int habitId, DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    return (select(habitLogs)
          ..where(
            (l) =>
                l.habitId.equals(habitId) &
                l.logDate.isBetweenValues(dayStart, dayEnd),
          ))
        .getSingleOrNull();
  }

  /// Returns the N most recent logs for a habit.
  Future<List<HabitLog>> getRecentLogs(int habitId, int limit) =>
      (select(habitLogs)
            ..where((l) => l.habitId.equals(habitId))
            ..orderBy([(l) => OrderingTerm.desc(l.logDate)])
            ..limit(limit))
          .get();

  /// Inserts or replaces a log entry (upsert by unique habitId+logDate key).
  Future<int> upsertLog(HabitLogsCompanion entry) =>
      into(habitLogs).insertOnConflictUpdate(entry);

  /// Inserts a new log and returns its id.
  Future<int> insertLog(HabitLogsCompanion entry) =>
      into(habitLogs).insert(entry);

  /// Updates an existing log row.
  Future<bool> updateLog(HabitLogsCompanion entry) =>
      update(habitLogs).replace(entry);
}
