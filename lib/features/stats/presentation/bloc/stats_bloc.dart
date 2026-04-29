import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/stats_repository.dart';
import '../../domain/usecases/get_heatmap_data_usecase.dart';
import '../../domain/usecases/get_bar_chart_data_usecase.dart';
import 'stats_event.dart';
import 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final StatsRepository _statsRepository;
  final GetHeatmapDataUseCase _getHeatmapData;
  final GetBarChartDataUseCase _getBarChartData;

  StatsBloc({
    required StatsRepository statsRepository,
    required GetHeatmapDataUseCase getHeatmapData,
    required GetBarChartDataUseCase getBarChartData,
  })  : _statsRepository = statsRepository,
        _getHeatmapData = getHeatmapData,
        _getBarChartData = getBarChartData,
        super(const StatsInitial()) {
    on<StatsLoaded>(_onLoaded);
    on<StatsHabitSelected>(_onHabitSelected);
    on<StatsRangeSelected>(_onRangeSelected);
    on<StatsBarGroupByChanged>(_onBarGroupByChanged);
  }

  Future<void> _onLoaded(StatsLoaded event, Emitter<StatsState> emit) async {
    emit(const StatsLoading());
    try {
      final habits = await _statsRepository.getHabits();
      if (habits.isEmpty) {
        emit(const StatsEmpty());
        return;
      }
      final selectedId = event.initialHabitId ?? habits.first.id;
      await _fetch(
        emit: emit,
        habits: habits,
        habitId: selectedId,
        rangeMonths: 3,
        groupBy: BarChartGroupBy.daily,
      );
    } catch (e) {
      emit(StatsError(e.toString()));
    }
  }

  Future<void> _onHabitSelected(
    StatsHabitSelected event,
    Emitter<StatsState> emit,
  ) async {
    final current = state;
    if (current is! StatsDataLoaded) return;
    await _fetch(
      emit: emit,
      habits: current.habits,
      habitId: event.habitId,
      rangeMonths: current.selectedRangeMonths,
      groupBy: current.barGroupBy,
    );
  }

  Future<void> _onRangeSelected(
    StatsRangeSelected event,
    Emitter<StatsState> emit,
  ) async {
    final current = state;
    if (current is! StatsDataLoaded) return;
    await _fetch(
      emit: emit,
      habits: current.habits,
      habitId: current.selectedHabitId,
      rangeMonths: event.months,
      groupBy: current.barGroupBy,
    );
  }

  Future<void> _onBarGroupByChanged(
    StatsBarGroupByChanged event,
    Emitter<StatsState> emit,
  ) async {
    final current = state;
    if (current is! StatsDataLoaded) return;
    await _fetch(
      emit: emit,
      habits: current.habits,
      habitId: current.selectedHabitId,
      rangeMonths: current.selectedRangeMonths,
      groupBy: event.groupBy,
    );
  }

  Future<void> _fetch({
    required Emitter<StatsState> emit,
    required List habits,
    required String habitId,
    required int rangeMonths,
    required BarChartGroupBy groupBy,
  }) async {
    final end = DateTime.now();
    final start = DateTime(end.year, end.month - rangeMonths, end.day);

    final heatmap = await _getHeatmapData(
      habitId: habitId,
      start: start,
      end: end,
    );
    final barChart = await _getBarChartData(
      habitId: habitId,
      start: start,
      end: end,
      groupBy: groupBy,
    );

    emit(StatsDataLoaded(
      habits: List.from(habits),
      selectedHabitId: habitId,
      selectedRangeMonths: rangeMonths,
      barGroupBy: groupBy,
      heatmapData: heatmap,
      barChartData: barChart,
    ));
  }
}
