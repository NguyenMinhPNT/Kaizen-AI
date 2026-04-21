import '../entities/timer_session.dart';

/// Abstract timer repository — manages foreground service and state persistence.
abstract class TimerRepository {
  /// Starts the foreground service and persists session start to SharedPrefs.
  Future<void> startSession({
    required String habitId,
    required String habitName,
    required int targetSeconds,
  });

  /// Persists the elapsed snapshot on pause; stops notification service.
  Future<void> pauseSession(int elapsedSeconds);

  /// Restarts the foreground service on resume; returns current elapsed seconds.
  Future<int> resumeSession({
    required String habitName,
    required int remainingSeconds,
  });

  /// Updates the foreground notification text with remaining time.
  Future<void> updateNotification(String habitName, int remainingSeconds);

  /// Stops the foreground service.
  Future<void> stopService();

  /// Clears all timer-related SharedPrefs keys.
  Future<void> clearSession();

  /// Reads SharedPrefs to recover an in-progress session after app kill.
  /// Returns null if no active session was found.
  TimerSession? recoverSession();
}
