// Duration-related constants for the timer and habit configuration
abstract class DurationConstants {
  DurationConstants._();

  static const int defaultMinutes = 10;
  static const int minimumMinutes = 10;
  static const int maximumMinutes = 120;
  static const int defaultIncrementMinutes = 5;

  static const int minimumIncrementMinutes = 1;
  static const int maximumIncrementMinutes = 30;

  // Heatmap color level thresholds (minutes)
  static const List<int> heatmapRedDurationLevels = [10, 15, 20, 25, 30];
}
