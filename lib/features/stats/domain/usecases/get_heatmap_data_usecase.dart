import '../entities/day_stat.dart';
import '../repositories/stats_repository.dart';

class GetHeatmapDataUseCase {
  final StatsRepository _repository;
  GetHeatmapDataUseCase(this._repository);

  Future<List<DayStat>> call({
    required String habitId,
    required DateTime start,
    required DateTime end,
  }) =>
      _repository.getHeatmapData(habitId: habitId, start: start, end: end);
}
