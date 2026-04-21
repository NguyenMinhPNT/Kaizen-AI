import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../timer/domain/entities/timer_session.dart';

/// Top-level callback required by flutter_foreground_task.
/// Runs in the foreground service isolate — keep it minimal.
@pragma('vm:entry-point')
void timerServiceCallback() {
  FlutterForegroundTask.setTaskHandler(_KaizenTimerTaskHandler());
}

/// Minimal task handler — the real countdown runs in the BLoC (main isolate).
/// The service exists only to keep the process alive and show the notification.
class _KaizenTimerTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {}

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  Future<void> onDestroy(DateTime timestamp) async {}
}

/// Wraps [flutter_foreground_task] and [SharedPreferences] for the timer feature.
class TimerService {
  final SharedPreferences _prefs;

  TimerService(this._prefs);

  // ─── Foreground service ──────────────────────────────────────────────────

  Future<void> startForegroundService(
    String habitName,
    int remainingSeconds,
  ) async {
    await FlutterForegroundTask.startService(
      serviceId: 256,
      notificationTitle: habitName,
      notificationText: '⏳ ${_fmt(remainingSeconds)} remaining',
      callback: timerServiceCallback,
    );
  }

  Future<void> updateNotification(
    String habitName,
    int remainingSeconds,
  ) async {
    await FlutterForegroundTask.updateService(
      notificationTitle: habitName,
      notificationText: '⏳ ${_fmt(remainingSeconds)} remaining',
    );
  }

  Future<void> stopForegroundService() async {
    await FlutterForegroundTask.stopService();
  }

  // ─── SharedPreferences persistence ──────────────────────────────────────

  Future<void> saveRunningState({
    required String habitId,
    required int targetSeconds,
  }) async {
    await _prefs.setString(AppConstants.prefTimerHabitId, habitId);
    await _prefs.setInt(
      AppConstants.prefTimerStartEpoch,
      DateTime.now().millisecondsSinceEpoch,
    );
    await _prefs.remove(AppConstants.prefTimerPausedEpoch);
    await _prefs.setInt(AppConstants.prefTimerElapsedSec, 0);
    await _prefs.setString(AppConstants.prefTimerStatus, 'running');
    await _prefs.setInt(AppConstants.prefTimerTargetSeconds, targetSeconds);
  }

  Future<void> savePausedState(int elapsedSeconds) async {
    await _prefs.setInt(AppConstants.prefTimerElapsedSec, elapsedSeconds);
    await _prefs.setInt(
      AppConstants.prefTimerPausedEpoch,
      DateTime.now().millisecondsSinceEpoch,
    );
    await _prefs.setString(AppConstants.prefTimerStatus, 'paused');
  }

  Future<void> saveResumedState() async {
    await _prefs.remove(AppConstants.prefTimerPausedEpoch);
    await _prefs.setInt(
      AppConstants.prefTimerStartEpoch,
      DateTime.now().millisecondsSinceEpoch,
    );
    await _prefs.setString(AppConstants.prefTimerStatus, 'running');
  }

  Future<void> clearState() async {
    await _prefs.remove(AppConstants.prefTimerHabitId);
    await _prefs.remove(AppConstants.prefTimerStartEpoch);
    await _prefs.remove(AppConstants.prefTimerElapsedSec);
    await _prefs.remove(AppConstants.prefTimerStatus);
    await _prefs.remove(AppConstants.prefTimerTargetSeconds);
    await _prefs.remove(AppConstants.prefTimerPausedEpoch);
  }

  /// Computes how many seconds have elapsed since last resume.
  /// Returns saved elapsed + time since last startEpoch.
  int computeElapsed() {
    final savedElapsed = _prefs.getInt(AppConstants.prefTimerElapsedSec) ?? 0;
    final startEpoch = _prefs.getInt(AppConstants.prefTimerStartEpoch);
    if (startEpoch == null) return savedElapsed;
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final deltaSec = ((nowMs - startEpoch) / 1000).floor();
    return savedElapsed + deltaSec;
  }

  /// Checks SharedPrefs for an active session.
  /// Returns null if no valid session exists.
  TimerSession? recoverSession() {
    final habitId = _prefs.getString(AppConstants.prefTimerHabitId);
    final status = _prefs.getString(AppConstants.prefTimerStatus);
    final targetSeconds = _prefs.getInt(AppConstants.prefTimerTargetSeconds);

    if (habitId == null || status == null || targetSeconds == null) return null;
    if (status != 'running' && status != 'paused') return null;

    final elapsedSeconds = status == 'running'
        ? computeElapsed()
        : (_prefs.getInt(AppConstants.prefTimerElapsedSec) ?? 0);

    if (elapsedSeconds >= targetSeconds) return null;

    final startEpoch = _prefs.getInt(AppConstants.prefTimerStartEpoch);
    final pausedEpoch = _prefs.getInt(AppConstants.prefTimerPausedEpoch);

    return TimerSession(
      habitId: habitId,
      targetSeconds: targetSeconds,
      elapsedSeconds: elapsedSeconds,
      status: status == 'running' ? TimerStatus.running : TimerStatus.paused,
      startedAt: startEpoch != null
          ? DateTime.fromMillisecondsSinceEpoch(startEpoch)
          : null,
      pausedAt: pausedEpoch != null
          ? DateTime.fromMillisecondsSinceEpoch(pausedEpoch)
          : null,
    );
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────

  String _fmt(int totalSeconds) {
    final m = totalSeconds ~/ 60;
    final s = totalSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
