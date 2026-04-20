import '../../domain/entities/habit_entity.dart';
import '../../domain/entities/habit_log_entity.dart';
import '../../domain/enums/habit_status.dart';
import '../../domain/repositories/habit_repository.dart';
import '../datasources/habit_local_datasource.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDatasource _datasource;

  HabitRepositoryImpl(this._datasource);

  @override
  Future<List<HabitEntity>> getAllHabits() => _datasource.getAllHabits();

  @override
  Stream<List<HabitEntity>> watchAllHabits() => _datasource.watchAllHabits();

  @override
  Future<HabitEntity?> getHabitById(String id) {
    final numId = int.tryParse(id);
    if (numId == null) return Future.value(null);
    return _datasource.getHabitById(numId);
  }

  @override
  Future<void> createHabit(HabitEntity habit) => _datasource.insertHabit(habit);

  @override
  Future<void> updateHabit(HabitEntity habit) => _datasource.updateHabit(habit);

  @override
  Future<void> deleteHabit(String id) {
    final numId = int.tryParse(id) ?? 0;
    return _datasource.deleteHabit(numId);
  }

  @override
  Future<void> archiveHabit(String id) {
    final numId = int.tryParse(id) ?? 0;
    return _datasource.archiveHabit(numId);
  }

  @override
  Future<void> levelUpHabit(String id) {
    final numId = int.tryParse(id) ?? 0;
    return _datasource.levelUpHabit(numId);
  }

  @override
  Future<void> levelDownHabit(String id) {
    final numId = int.tryParse(id) ?? 0;
    return _datasource.levelDownHabit(numId);
  }

  @override
  Future<void> logHabit(HabitLogEntity log) => _datasource.logHabit(log);

  @override
  Future<List<HabitLogEntity>> getLogsForHabit(String habitId) {
    final numId = int.tryParse(habitId) ?? 0;
    return _datasource.getLogsForHabit(numId);
  }

  @override
  Future<HabitLogEntity?> getLogForDate(String habitId, DateTime date) {
    final numId = int.tryParse(habitId) ?? 0;
    return _datasource.getLogForDate(numId, date);
  }

  @override
  Future<HabitStatus?> getTodayStatus(String habitId) {
    final numId = int.tryParse(habitId) ?? 0;
    return _datasource.getTodayStatus(numId);
  }
}
