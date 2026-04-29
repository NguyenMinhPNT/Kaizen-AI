import '../../domain/entities/day_stat.dart';
import '../../domain/entities/period_summary.dart';
import '../../domain/repositories/stats_repository.dart';
import '../../../habit/domain/entities/habit_entity.dart';
import '../datasources/stats_local_datasource.dart';

class StatsRepositoryImpl implements StatsRepository {
  final StatsLocalDatasource _datasource;

  StatsRepositoryImpl(this._datasource);

  @override
  Future<List<HabitEntity>> getHabits() => _datasource.getHabits();

  @override
  Future<List<DayStat>> getHeatmapData({
    required String habitId,
    required DateTime start,
    required DateTime end,
  }) {
    final id = int.tryParse(habitId) ?? 0;
    return _datasource.getHeatmapData(habitId: id, start: start, end: end);
  }

  @override
  Future<List<PeriodSummary>> getBarChartData({
    required String habitId,
    required DateTime start,
    required DateTime end,
    required BarChartGroupBy groupBy,
  }) {
    final id = int.tryParse(habitId) ?? 0;
    return _datasource.getBarChartData(
      habitId: id,
      start: start,
      end: end,
      groupBy: groupBy,
    );
  }
}
