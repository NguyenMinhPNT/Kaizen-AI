import 'package:equatable/equatable.dart';

sealed class TimerState extends Equatable {
  const TimerState();
}

/// No active session — show "Tap to Start".
class TimerInitialState extends TimerState {
  const TimerInitialState();

  @override
  List<Object?> get props => [];
}

/// Timer is counting down.
class TimerRunningState extends TimerState {
  /// Remaining seconds in the session.
  final int remaining;

  /// 0.0 (not started) → 1.0 (complete).
  final double progress;

  const TimerRunningState({required this.remaining, required this.progress});

  @override
  List<Object?> get props => [remaining, progress];
}

/// Timer is paused — user can resume or give up.
class TimerPausedState extends TimerState {
  final int remaining;
  final double progress;

  const TimerPausedState({required this.remaining, required this.progress});

  @override
  List<Object?> get props => [remaining, progress];
}

/// Session ended early by user.
class TimerGaveUpState extends TimerState {
  /// Percentage of the session completed (0–100).
  final double completionPct;

  const TimerGaveUpState({required this.completionPct});

  @override
  List<Object?> get props => [completionPct];
}

/// Session completed successfully — full duration reached.
class TimerFinishedState extends TimerState {
  /// Total seconds actually elapsed.
  final int actualSeconds;

  const TimerFinishedState({required this.actualSeconds});

  @override
  List<Object?> get props => [actualSeconds];
}

/// An error occurred (e.g. habit not found).
class TimerErrorState extends TimerState {
  final String message;

  const TimerErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
