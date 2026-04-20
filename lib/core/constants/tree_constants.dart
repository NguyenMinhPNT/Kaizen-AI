// Tree growth stage thresholds (total completed days)
abstract class TreeConstants {
  TreeConstants._();

  /// Minimum completed days required to reach each stage.
  /// Index = stage number (0-5).
  static const List<int> stageThresholds = [0, 3, 7, 21, 42, 66];

  static const List<String> stageNames = [
    'Hạt', // 0 — Seed
    'Mầm', // 1 — Sprout
    'Cây con', // 2 — Sapling
    'Cây', // 3 — Young Tree
    'Cây to', // 4 — Big Tree
    'Cây cổ thụ', // 5 — Ancient Tree
  ];

  static const int totalStages = 6;
  static const int finalStage = 5;

  /// Returns the stage index (0-5) for a given number of completed days.
  static int stageFor(int totalCompletedDays) {
    for (int i = stageThresholds.length - 1; i >= 0; i--) {
      if (totalCompletedDays >= stageThresholds[i]) return i;
    }
    return 0;
  }

  /// Returns the days remaining until the next stage, or null if at max stage.
  static int? daysToNextStage(int totalCompletedDays) {
    final currentStage = stageFor(totalCompletedDays);
    if (currentStage >= finalStage) return null;
    return stageThresholds[currentStage + 1] - totalCompletedDays;
  }
}
