// Core app-wide constants
abstract class AppConstants {
  AppConstants._();

  static const int defaultHabitDurationMinutes = 10;
  static const int defaultIncrementMinutes = 5;
  static const int defaultMaxDurationMinutes = 120;
  static const int minimumDurationMinutes = 10;

  static const int analysisWindowDays = 7;
  static const int analysisMinLogsRequired = 5;

  static const double copilotConfidenceThreshold = 0.60;
  static const double autopilotConfidenceThreshold = 0.70;

  static const int undoSnackbarDurationSeconds = 5;

  static const String defaultTreeType = 'oak';
  static const String defaultLevelUpMode = 'manual';
  static const String defaultColorHex = '#4CAF50';

  // SharedPreferences keys
  static const String prefThemeMode = 'theme_mode';
  static const String prefGlobalAiMode = 'global_ai_mode';
  static const String prefOnboardingDone = 'onboarding_done';
  static const String prefTimerHabitId = 'timer_active_habit_id';
  static const String prefTimerStartEpoch = 'timer_start_epoch';
  static const String prefTimerElapsedSec = 'timer_elapsed_seconds';
  static const String prefTimerStatus = 'timer_status';
}
