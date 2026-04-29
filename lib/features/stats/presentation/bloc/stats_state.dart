import 'package:equatable/equatable.dart';
import '../../domain/entities/day_stat.dart';
import '../../domain/entities/period_summary.dart';
import '../../domain/repositories/stats_repository.dart';
import '../../../habit/domain/entities/habit_entity.dart';

abstract class StatsState extends Equatable {
  const StatsState();
  @override
  List<Object?> get props => [];
}

class StatsInitial extends StatsState {
  const StatsInitial();
}

class StatsLoading extends StatsState {
  const StatsLoading();
}

class StatsDataLoaded extends StatsState {
  final List<HabitEntity> habits;
  final String selectedHabitId;
  final int selectedRangeMonths;
  final BarChartGroupBy barGroupBy;
  final List<DayStat> heatmapData;
  final List<PeriodSummary> barChartData;

  const StatsDataLoaded({
    required this.habits,
    required this.selectedHabitId,
    required this.selectedRangeMonths,
    required this.barGroupBy,
    required this.heatmapData,
    required this.barChartData,
  });

  StatsDataLoaded copyWith({
    List<HabitEntity>? habits,
    String? selectedHabitId,
    int? selectedRangeMonths,
    BarChartGroupBy? barGroupBy,
    List<DayStat>? heatmapData,
    List<PeriodSummary>? barChartData,
  }) =>
      StatsDataLoaded(
        habits: habits ?? this.habits,
        selectedHabitId: selectedHabitId ?? this.selectedHabitId,
        selectedRangeMonths: selectedRangeMonths ?? this.selectedRangeMonths,
        barGroupBy: barGroupBy ?? this.barGroupBy,
        heatmapData: heatmapData ?? this.heatmapData,
        barChartData: barChartData ?? this.barChartData,
      );

  @override
  List<Object?> get props => [
        habits,
        selectedHabitId,
        selectedRangeMonths,
        barGroupBy,
        heatmapData,
        barChartData,
      ];
}

class StatsError extends StatsState {
  final String message;
  const StatsError(this.message);
  @override
  List<Object?> get props => [message];
}

class StatsEmpty extends StatsState {
  const StatsEmpty();
}
