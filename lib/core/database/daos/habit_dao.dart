import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables.dart';

part 'habit_dao.g.dart';

@DriftAccessor(tables: [Habits])
class HabitDao extends DatabaseAccessor<AppDatabase> with _$HabitDaoMixin {
  HabitDao(super.db);

  /// Returns all non-archived habits ordered by creation date descending.
  Future<List<Habit>> getAllHabits() => (select(habits)
        ..where((h) => h.isArchived.equals(false))
        ..orderBy([(h) => OrderingTerm.desc(h.createdAt)]))
      .get();

  /// Stream of all non-archived habits — updates when any habit changes.
  Stream<List<Habit>> watchAllHabits() => (select(habits)
        ..where((h) => h.isArchived.equals(false))
        ..orderBy([(h) => OrderingTerm.desc(h.createdAt)]))
      .watch();

  /// Returns the habit with the given [id], or null if not found.
  Future<Habit?> getHabitById(int id) =>
      (select(habits)..where((h) => h.id.equals(id))).getSingleOrNull();

  /// Inserts a new habit and returns its auto-generated id.
  Future<int> insertHabit(HabitsCompanion entry) => into(habits).insert(entry);

  /// Updates an existing habit row.
  Future<bool> updateHabit(HabitsCompanion entry) =>
      update(habits).replace(entry);

  /// Hard-deletes a habit by id.
  Future<int> deleteHabit(int id) =>
      (delete(habits)..where((h) => h.id.equals(id))).go();

  /// Soft-deletes (archives) a habit.
  Future<int> archiveHabit(int id) =>
      (update(habits)..where((h) => h.id.equals(id))).write(
        HabitsCompanion(
          isArchived: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Returns all archived habits.
  Future<List<Habit>> getArchivedHabits() =>
      (select(habits)..where((h) => h.isArchived.equals(true))).get();
}
