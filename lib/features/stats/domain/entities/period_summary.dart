import 'package:equatable/equatable.dart';

/// Aggregated stats for a bar-chart period (day / week / month).
class PeriodSummary extends Equatable {
  /// Label shown on the X axis (e.g. "Mon", "W12", "Jan").
  final String label;

  /// Start of this period.
  final DateTime periodStart;

  /// Average completion percentage across all logs in this period (0–100).
  final double avgCompletionPct;

  /// Total minutes actually tracked in this period.
  final int totalMinutes;

  /// Number of days that had a completed log.
  final int completedDays;

  /// Total number of days in the period (for density calculation).
  final int totalDays;

  const PeriodSummary({
    required this.label,
    required this.periodStart,
    required this.avgCompletionPct,
    required this.totalMinutes,
    required this.completedDays,
    required this.totalDays,
  });

  @override
  List<Object?> get props => [
        label,
        periodStart,
        avgCompletionPct,
        totalMinutes,
        completedDays,
        totalDays,
      ];
}
