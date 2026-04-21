import '../../domain/entities/timer_session.dart';
import '../../domain/repositories/timer_repository.dart';
import '../datasources/timer_service.dart';

class TimerRepositoryImpl implements TimerRepository {
  final TimerService _service;

  TimerRepositoryImpl(this._service);

  @override
  Future<void> startSession({
    required String habitId,
    required String habitName,
    required int targetSeconds,
  }) async {
    await _service.saveRunningState(
      habitId: habitId,
      targetSeconds: targetSeconds,
    );
    await _service.startForegroundService(habitName, targetSeconds);
  }

  @override
  Future<void> pauseSession(int elapsedSeconds) async {
    await _service.savePausedState(elapsedSeconds);
    await _service.stopForegroundService();
  }

  @override
  Future<int> resumeSession({
    required String habitName,
    required int remainingSeconds,
  }) async {
    await _service.saveResumedState();
    await _service.startForegroundService(habitName, remainingSeconds);
    return _service.computeElapsed();
  }

  @override
  Future<void> updateNotification(
    String habitName,
    int remainingSeconds,
  ) =>
      _service.updateNotification(habitName, remainingSeconds);

  @override
  Future<void> stopService() => _service.stopForegroundService();

  @override
  Future<void> clearSession() => _service.clearState();

  @override
  TimerSession? recoverSession() => _service.recoverSession();
}
