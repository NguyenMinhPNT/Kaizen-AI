import '../entities/day_stat.dart';
import '../entities/period_summary.dart';
import '../../../habit/domain/entities/habit_entity.dart';

/// Enum for bar chart grouping granularity.
enum BarChartGroupBy { daily, monthly }

abstract class StatsRepository {
  /// Returns all habits (non-archived) for the selector.
  Future<List<HabitEntity>> getHabits();

  /// Returns one [DayStat] per calendar day in [start..end] for [habitId].
  /// Days without a log are included with status=null.
  Future<List<DayStat>> getHeatmapData({
    required String habitId,
    required DateTime start,
    required DateTime end,
  });

  /// Returns aggregated [PeriodSummary] rows for the bar chart.
  Future<List<PeriodSummary>> getBarChartData({
    required String habitId,
    required DateTime start,
    required DateTime end,
    required BarChartGroupBy groupBy,
  });
}
