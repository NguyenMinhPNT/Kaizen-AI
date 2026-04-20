import '../entities/habit_entity.dart';
import '../entities/habit_log_entity.dart';
import '../enums/habit_status.dart';

abstract class HabitRepository {
  Future<List<HabitEntity>> getAllHabits();
  Stream<List<HabitEntity>> watchAllHabits();
  Future<HabitEntity?> getHabitById(String id);
  Future<void> createHabit(HabitEntity habit);
  Future<void> updateHabit(HabitEntity habit);
  Future<void> deleteHabit(String id);
  Future<void> archiveHabit(String id);
  Future<void> levelUpHabit(String id);
  Future<void> levelDownHabit(String id);
  Future<void> logHabit(HabitLogEntity log);
  Future<List<HabitLogEntity>> getLogsForHabit(String habitId);
  Future<HabitLogEntity?> getLogForDate(String habitId, DateTime date);
  Future<HabitStatus?> getTodayStatus(String habitId);
}
