import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/timer_session.dart';
import '../../domain/repositories/timer_repository.dart';
import '../../domain/usecases/finish_timer_usecase.dart';
import '../../domain/usecases/give_up_timer_usecase.dart';
import '../../domain/usecases/pause_timer_usecase.dart';
import '../../domain/usecases/resume_timer_usecase.dart';
import '../../domain/usecases/start_timer_usecase.dart';
import 'timer_event.dart';
import 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final StartTimerUseCase _start;
  final PauseTimerUseCase _pause;
  final ResumeTimerUseCase _resume;
  final GiveUpTimerUseCase _giveUp;
  final FinishTimerUseCase _finish;
  final TimerRepository _timerRepo;

  StreamSubscription<void>? _tickSubscription;

  /// Mutable runtime state tracked inside the bloc.
  int _remaining = 0;
  int _targetSeconds = 0;
  String _habitId = '';
  String _habitName = '';

  TimerBloc({
    required StartTimerUseCase start,
    required PauseTimerUseCase pause,
    required ResumeTimerUseCase resume,
    required GiveUpTimerUseCase giveUp,
    required FinishTimerUseCase finish,
    required TimerRepository timerRepo,
  })  : _start = start,
        _pause = pause,
        _resume = resume,
        _giveUp = giveUp,
        _finish = finish,
        _timerRepo = timerRepo,
        super(const TimerInitialState()) {
    on<TimerStarted>(_onStarted);
    on<TimerRestoreEvent>(_onRestore);
    on<TimerPausedEvent>(_onPaused);
    on<TimerResumedEvent>(_onResumed);
    on<TimerGaveUpEvent>(_onGaveUp);
    on<TimerTick>(_onTick, transformer: _sequential());
  }

  // ─── Event handlers ──────────────────────────────────────────────────────

  Future<void> _onStarted(TimerStarted event, Emitter<TimerState> emit) async {
    _habitId = event.habitId;
    _habitName = event.habitName;
    _targetSeconds = event.targetSeconds;
    _remaining = event.targetSeconds;

    try {
      await _start(
        habitId: _habitId,
        habitName: _habitName,
        targetSeconds: _targetSeconds,
      );
    } catch (_) {
      // Foreground service failure is non-fatal — timer still runs in app
    }

    emit(TimerRunningState(remaining: _remaining, progress: 0.0));
    _startTicking();
  }

  void _onPaused(TimerPausedEvent event, Emitter<TimerState> emit) {
    _tickSubscription?.cancel();
    _tickSubscription = null;

    final elapsed = _targetSeconds - _remaining;
    final progress = _targetSeconds > 0 ? elapsed / _targetSeconds : 0.0;

    _pause(elapsed).ignore();

    emit(TimerPausedState(remaining: _remaining, progress: progress));
  }

  Future<void> _onResumed(
    TimerResumedEvent event,
    Emitter<TimerState> emit,
  ) async {
    final elapsed = _targetSeconds - _remaining;
    final progress = _targetSeconds > 0 ? elapsed / _targetSeconds : 0.0;

    try {
      await _resume(habitName: _habitName, remainingSeconds: _remaining);
    } catch (_) {
      // Non-fatal
    }

    emit(TimerRunningState(remaining: _remaining, progress: progress));
    _startTicking();
  }

  Future<void> _onGaveUp(
    TimerGaveUpEvent event,
    Emitter<TimerState> emit,
  ) async {
    _tickSubscription?.cancel();
    _tickSubscription = null;

    final elapsed = _targetSeconds - _remaining;
    final completionPct = _targetSeconds > 0
        ? (elapsed / _targetSeconds * 100).clamp(0.0, 100.0)
        : 0.0;

    try {
      await _giveUp(
        habitId: _habitId,
        elapsedSeconds: elapsed,
        targetSeconds: _targetSeconds,
      );
    } catch (e) {
      emit(TimerErrorState(e.toString()));
      return;
    }

    emit(TimerGaveUpState(completionPct: completionPct));
  }

  Future<void> _onRestore(
    TimerRestoreEvent event,
    Emitter<TimerState> emit,
  ) async {
    final session = _timerRepo.recoverSession();
    if (session == null) return;
    if (session.habitId != event.habitId) return;

    _habitId = session.habitId;
    _habitName = event.habitName;
    _targetSeconds = session.targetSeconds;
    _remaining = session.remainingSeconds;

    if (session.status == TimerStatus.running) {
      emit(TimerRunningState(
        remaining: _remaining,
        progress: session.progress,
      ));
      _startTicking();
      return;
    }

    if (session.status == TimerStatus.paused) {
      if (_isPausedSessionStale(session)) {
        final completionPct = session.completionPct;
        try {
          await _giveUp(
            habitId: _habitId,
            elapsedSeconds: session.elapsedSeconds,
            targetSeconds: _targetSeconds,
            date: session.pausedAt,
          );
        } catch (e) {
          emit(TimerErrorState(e.toString()));
          return;
        }
        emit(TimerGaveUpState(completionPct: completionPct));
        return;
      }

      emit(TimerPausedState(
        remaining: _remaining,
        progress: session.progress,
      ));
    }
  }

  bool _isPausedSessionStale(TimerSession session) {
    if (session.pausedAt == null) return false;
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    return session.pausedAt!.isBefore(midnight);
  }

  Future<void> _onTick(TimerTick event, Emitter<TimerState> emit) async {
    _remaining--;

    if (_remaining <= 0) {
      _remaining = 0;
      _tickSubscription?.cancel();
      _tickSubscription = null;

      try {
        await _finish(habitId: _habitId, targetSeconds: _targetSeconds);
      } catch (e) {
        emit(TimerErrorState(e.toString()));
        return;
      }

      emit(TimerFinishedState(actualSeconds: _targetSeconds));
    } else {
      final progress =
          ((_targetSeconds - _remaining) / _targetSeconds).clamp(0.0, 1.0);
      emit(TimerRunningState(remaining: _remaining, progress: progress));

      // Update notification every 10 seconds to reduce overhead
      if (_remaining % 10 == 0) {
        _timerRepo.updateNotification(_habitName, _remaining).ignore();
      }
    }
  }

  // ─── Tick stream ─────────────────────────────────────────────────────────

  void _startTicking() {
    _tickSubscription?.cancel();
    _tickSubscription =
        Stream<void>.periodic(const Duration(seconds: 1)).listen(
      (_) => add(const TimerTick()),
    );
  }

  /// Sequential event transformer so ticks are processed one at a time.
  EventTransformer<TimerTick> _sequential() =>
      (events, mapper) => events.asyncExpand(mapper);

  @override
  Future<void> close() {
    _tickSubscription?.cancel();
    return super.close();
  }
}
