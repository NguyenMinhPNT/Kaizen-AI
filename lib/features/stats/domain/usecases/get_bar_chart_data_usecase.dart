import '../entities/period_summary.dart';
import '../repositories/stats_repository.dart';

class GetBarChartDataUseCase {
  final StatsRepository _repository;
  GetBarChartDataUseCase(this._repository);

  Future<List<PeriodSummary>> call({
    required String habitId,
    required DateTime start,
    required DateTime end,
    required BarChartGroupBy groupBy,
  }) =>
      _repository.getBarChartData(
        habitId: habitId,
        start: start,
        end: end,
        groupBy: groupBy,
      );
}
