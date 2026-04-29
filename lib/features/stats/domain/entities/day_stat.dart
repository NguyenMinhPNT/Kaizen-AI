import 'package:equatable/equatable.dart';
import '../../../habit/domain/enums/habit_status.dart';

/// Stats for a single calendar day — used to render one heatmap cell.
class DayStat extends Equatable {
  final DateTime date;

  /// Null when no log exists for this day.
  final HabitStatus? status;

  /// Actual minutes tracked for this day (0 when no log).
  final int durationMinutes;

  /// actual/target × 100 (0.0 when no log).
  final double completionPct;

  const DayStat({
    required this.date,
    required this.status,
    required this.durationMinutes,
    required this.completionPct,
  });

  bool get hasLog => status != null;

  @override
  List<Object?> get props => [date, status, durationMinutes, completionPct];
}
