import 'package:equatable/equatable.dart';

/// Timer session status — 5 states from the architecture.
enum TimerStatus {
  initial,
  running,
  paused,
  gaveUp,
  finished,
}

/// Snapshot of the active (or completed) timer session.
class TimerSession extends Equatable {
  final String habitId;
  final int targetSeconds;
  final int elapsedSeconds;
  final TimerStatus status;
  final DateTime? startedAt;
  final DateTime? pausedAt;

  const TimerSession({
    required this.habitId,
    required this.targetSeconds,
    required this.elapsedSeconds,
    required this.status,
    this.startedAt,
    this.pausedAt,
  });

  int get remainingSeconds =>
      (targetSeconds - elapsedSeconds).clamp(0, targetSeconds);

  double get progress => targetSeconds > 0
      ? (elapsedSeconds / targetSeconds).clamp(0.0, 1.0)
      : 0.0;

  double get completionPct => progress * 100.0;

  TimerSession copyWith({
    String? habitId,
    int? targetSeconds,
    int? elapsedSeconds,
    TimerStatus? status,
    DateTime? startedAt,
    DateTime? pausedAt,
  }) {
    return TimerSession(
      habitId: habitId ?? this.habitId,
      targetSeconds: targetSeconds ?? this.targetSeconds,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      pausedAt: pausedAt ?? this.pausedAt,
    );
  }

  @override
  List<Object?> get props => [
        habitId,
        targetSeconds,
        elapsedSeconds,
        status,
        startedAt,
        pausedAt,
      ];
}
