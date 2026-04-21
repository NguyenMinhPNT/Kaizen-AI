import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/habit_dao.dart';
import '../../../../core/database/daos/habit_log_dao.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/entities/habit_log_entity.dart';
import '../../domain/enums/habit_status.dart';
import '../models/habit_model.dart';

class HabitLocalDatasource {
  final HabitDao _habitDao;
  final HabitLogDao _habitLogDao;
  final AppDatabase _database;

  HabitLocalDatasource(
    this._habitDao,
    this._habitLogDao,
    this._database,
  );

  Future<List<HabitEntity>> getAllHabits() async {
    final rows = await _habitDao.getAllHabits();
    return rows.map((r) => r.toEntity()).toList();
  }

  Stream<List<HabitEntity>> watchAllHabits() => _habitDao.watchAllHabits().map(
        (rows) => rows.map((r) => r.toEntity()).toList(),
      );

  Future<HabitEntity?> getHabitById(int id) async {
    final row = await _habitDao.getHabitById(id);
    return row?.toEntity();
  }

  Future<void> insertHabit(HabitEntity habit) async {
    final companion = habit.toCompanion();
    // Insert without ID (auto-increment)
    await _habitDao.insertHabit(HabitsCompanion(
      name: companion.name,
      description: companion.description,
      iconCode: companion.iconCode,
      colorHex: companion.colorHex,
      currentDurationMinutes: companion.currentDurationMinutes,
      maxDurationMinutes: companion.maxDurationMinutes,
      incrementMinutes: companion.incrementMinutes,
      treeType: companion.treeType,
      levelUpMode: companion.levelUpMode,
    ));
  }

  Future<void> updateHabit(HabitEntity habit) async {
    await _habitDao.updateHabit(habit.toCompanion());
  }

  Future<void> deleteHabit(int id) async {
    await _habitDao.transaction(() async {
      await _habitLogDao.deleteLogsForHabit(id);
      await _database.habitTreeDao.deleteTreeForHabit(id);
      await _habitDao.deleteHabit(id);
    });
  }

  Future<void> archiveHabit(int id) async {
    await _habitDao.archiveHabit(id);
  }

  Future<void> levelUpHabit(int id) async {
    final row = await _habitDao.getHabitById(id);
    if (row == null) return;
    final next = row.currentDurationMinutes + row.incrementMinutes;
    final capped =
        next > row.maxDurationMinutes ? row.maxDurationMinutes : next;
    await _habitDao.updateHabit(HabitsCompanion(
      id: Value(row.id),
      currentDurationMinutes: Value(capped),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Future<void> levelDownHabit(int id) async {
    final row = await _habitDao.getHabitById(id);
    if (row == null) return;
    final prev = row.currentDurationMinutes - row.incrementMinutes;
    const minDuration = 10;
    final floored = prev < minDuration ? minDuration : prev;
    await _habitDao.updateHabit(HabitsCompanion(
      id: Value(row.id),
      currentDurationMinutes: Value(floored),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Future<void> logHabit(HabitLogEntity log) async {
    final habitId = int.tryParse(log.habitId) ?? 0;
    await _habitLogDao.upsertLog(HabitLogsCompanion(
      habitId: Value(habitId),
      logDate: Value(log.date),
      targetDurationMinutes: Value(log.durationMinutes),
      actualDurationMinutes: Value(log.durationMinutes),
      status: Value(log.status.name),
    ));
  }

  Future<List<HabitLogEntity>> getLogsForHabit(int habitId) async {
    final rows = await _habitLogDao.getLogsForHabit(habitId);
    return rows.map(_logToEntity).toList();
  }

  Future<HabitLogEntity?> getLogForDate(int habitId, DateTime date) async {
    final row = await _habitLogDao.getLogForHabitOnDate(habitId, date);
    return row != null ? _logToEntity(row) : null;
  }

  Future<HabitStatus?> getTodayStatus(int habitId) async {
    final row =
        await _habitLogDao.getLogForHabitOnDate(habitId, DateTime.now());
    if (row == null) return null;
    return HabitStatus.values.firstWhere(
      (s) => s.name == row.status,
      orElse: () => HabitStatus.skipped,
    );
  }

  Future<void> logTimerSession({
    required int habitId,
    required int targetMinutes,
    required int actualMinutes,
    required String status,
    required double completionPct,
    required DateTime date,
  }) async {
    await _habitLogDao.upsertLog(HabitLogsCompanion(
      habitId: Value(habitId),
      logDate: Value(DateTime(date.year, date.month, date.day)),
      targetDurationMinutes: Value(targetMinutes),
      actualDurationMinutes: Value(actualMinutes),
      status: Value(status),
      completionPercentage: Value(completionPct),
    ));
  }

  static HabitLogEntity _logToEntity(HabitLog log) => HabitLogEntity(
        id: log.id.toString(),
        habitId: log.habitId.toString(),
        date: log.logDate,
        status: HabitStatus.values.firstWhere(
          (s) => s.name == log.status,
          orElse: () => HabitStatus.skipped,
        ),
        durationMinutes: log.actualDurationMinutes,
        createdAt: log.createdAt,
      );
}
