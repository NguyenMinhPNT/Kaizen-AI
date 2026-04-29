import 'package:equatable/equatable.dart';
import '../../domain/repositories/stats_repository.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();

  @override
  List<Object?> get props => [];
}

/// Load habits list + trigger initial query.
class StatsLoaded extends StatsEvent {
  /// If not null, pre-selects this habit in the selector.
  final String? initialHabitId;
  const StatsLoaded({this.initialHabitId});
  @override
  List<Object?> get props => [initialHabitId];
}

/// User selects a different habit from the chip row.
class StatsHabitSelected extends StatsEvent {
  final String habitId;
  const StatsHabitSelected(this.habitId);
  @override
  List<Object?> get props => [habitId];
}

/// User selects a different date range (3 / 6 / 12 months).
class StatsRangeSelected extends StatsEvent {
  final int months;
  const StatsRangeSelected(this.months);
  @override
  List<Object?> get props => [months];
}

/// User toggles bar chart grouping (daily / weekly / monthly).
class StatsBarGroupByChanged extends StatsEvent {
  final BarChartGroupBy groupBy;
  const StatsBarGroupByChanged(this.groupBy);
  @override
  List<Object?> get props => [groupBy];
}
