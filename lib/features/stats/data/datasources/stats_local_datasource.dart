import '../../../../core/database/daos/habit_dao.dart';
import '../../../../core/database/daos/habit_log_dao.dart';
import '../../domain/entities/day_stat.dart';
import '../../domain/entities/period_summary.dart';
import '../../domain/repositories/stats_repository.dart';
import '../../../habit/data/models/habit_model.dart';
import '../../../habit/domain/entities/habit_entity.dart';
import '../../../habit/domain/enums/habit_status.dart';

class StatsLocalDatasource {
  final HabitDao _habitDao;
  final HabitLogDao _habitLogDao;

  StatsLocalDatasource(this._habitDao, this._habitLogDao);

  Future<List<HabitEntity>> getHabits() async {
    final rows = await _habitDao.getAllHabits();
    return rows.map((r) => r.toEntity()).toList();
  }

  Future<List<DayStat>> getHeatmapData({
    required int habitId,
    required DateTime start,
    required DateTime end,
  }) async {
    final logs = await _habitLogDao.getLogsForHabitInRange(habitId, start, end);

    // Index logs by day-midnight for O(1) lookup
    final logMap = <String, dynamic>{};
    for (final log in logs) {
      final key = _dayKey(log.logDate);
      logMap[key] = log;
    }

    final result = <DayStat>[];
    var cursor = DateTime(start.year, start.month, start.day);
    final endDay = DateTime(end.year, end.month, end.day);

    while (!cursor.isAfter(endDay)) {
      final key = _dayKey(cursor);
      final log = logMap[key];
      if (log != null) {
        final status = HabitStatus.values.firstWhere(
          (s) => s.name == log.status,
          orElse: () => HabitStatus.skipped,
        );
        result.add(DayStat(
          date: cursor,
          status: status,
          durationMinutes: log.actualDurationMinutes as int,
          completionPct: log.completionPercentage as double,
        ));
      } else {
        result.add(DayStat(
          date: cursor,
          status: null,
          durationMinutes: 0,
          completionPct: 0.0,
        ));
      }
      cursor = cursor.add(const Duration(days: 1));
    }

    return result;
  }

  Future<List<PeriodSummary>> getBarChartData({
    required int habitId,
    required DateTime start,
    required DateTime end,
    required BarChartGroupBy groupBy,
  }) async {
    final logs = await _habitLogDao.getLogsForHabitInRange(habitId, start, end);

    switch (groupBy) {
      case BarChartGroupBy.daily:
        return _groupDaily(logs, start, end);
      case BarChartGroupBy.monthly:
        return _groupMonthly(logs, start, end);
    }
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  static String _dayKey(DateTime d) => '${d.year}-${d.month}-${d.day}';

  List<PeriodSummary> _groupDaily(logs, DateTime start, DateTime end) {
    final logMap = <String, dynamic>{};
    for (final l in logs) {
      logMap[_dayKey(l.logDate)] = l;
    }

    final result = <PeriodSummary>[];
    var cursor = DateTime(start.year, start.month, start.day);
    final endDay = DateTime(end.year, end.month, end.day);

    while (!cursor.isAfter(endDay)) {
      final log = logMap[_dayKey(cursor)];
      result.add(PeriodSummary(
        label: '${cursor.day}/${cursor.month}',
        periodStart: cursor,
        avgCompletionPct:
            log != null ? (log.completionPercentage as double) : 0.0,
        totalMinutes: log != null ? (log.actualDurationMinutes as int) : 0,
        completedDays: (log != null && log.status == 'completed') ? 1 : 0,
        totalDays: 1,
      ));
      cursor = cursor.add(const Duration(days: 1));
    }
    return result;
  }

  List<PeriodSummary> _groupMonthly(logs, DateTime start, DateTime end) {
    final monthBuckets = <String, List<dynamic>>{};
    for (final l in logs) {
      final key = '${l.logDate.year}-${l.logDate.month}';
      monthBuckets.putIfAbsent(key, () => []);
      monthBuckets[key]!.add(l);
    }

    // Collect all months in range
    final allMonths = <String, DateTime>{};
    var cursor = DateTime(start.year, start.month, 1);
    while (cursor.isBefore(DateTime(end.year, end.month + 1, 1))) {
      allMonths['${cursor.year}-${cursor.month}'] = cursor;
      cursor = DateTime(cursor.year, cursor.month + 1, 1);
    }

    const monthLabels = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final result = <PeriodSummary>[];
    for (final entry in allMonths.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value))) {
      final key = entry.key;
      final monthStart = entry.value;
      final monthLogs = monthBuckets[key] ?? [];
      final daysInMonth =
          DateTime(monthStart.year, monthStart.month + 1, 0).day;
      final completedLogs = monthLogs.where((l) => l.status == 'completed');
      final totalMinutes = monthLogs.fold<int>(
        0,
        (sum, l) => sum + (l.actualDurationMinutes as int),
      );
      final avgPct = monthLogs.isEmpty
          ? 0.0
          : monthLogs.fold<double>(
                0.0,
                (sum, l) => sum + (l.completionPercentage as double),
              ) /
              monthLogs.length;

      result.add(PeriodSummary(
        label: monthLabels[monthStart.month - 1],
        periodStart: monthStart,
        avgCompletionPct: avgPct,
        totalMinutes: totalMinutes,
        completedDays: completedLogs.length,
        totalDays: daysInMonth,
      ));
    }
    return result;
  }
}
