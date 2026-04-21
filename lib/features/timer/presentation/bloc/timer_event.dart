import 'package:equatable/equatable.dart';

sealed class TimerEvent extends Equatable {
  const TimerEvent();
}

/// User pressed "Tap to Start" or app recovered a running session.
class TimerStarted extends TimerEvent {
  final String habitId;
  final String habitName;
  final int targetSeconds;

  const TimerStarted({
    required this.habitId,
    required this.habitName,
    required this.targetSeconds,
  });

  @override
  List<Object?> get props => [habitId, habitName, targetSeconds];
}

/// User pressed "Pause".
class TimerPausedEvent extends TimerEvent {
  const TimerPausedEvent();

  @override
  List<Object?> get props => [];
}

/// User pressed "Resume".
class TimerResumedEvent extends TimerEvent {
  const TimerResumedEvent();

  @override
  List<Object?> get props => [];
}

/// Attempt to restore an existing session when the timer screen opens.
class TimerRestoreEvent extends TimerEvent {
  final String habitId;
  final String habitName;
  final int targetSeconds;

  const TimerRestoreEvent({
    required this.habitId,
    required this.habitName,
    required this.targetSeconds,
  });

  @override
  List<Object?> get props => [habitId, habitName, targetSeconds];
}

/// User pressed "Give Up".
class TimerGaveUpEvent extends TimerEvent {
  const TimerGaveUpEvent();

  @override
  List<Object?> get props => [];
}

/// Internal — emitted by the tick stream every second.
class TimerTick extends TimerEvent {
  const TimerTick();

  @override
  List<Object?> get props => [];
}
