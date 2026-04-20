/// All route path constants for GoRouter.
abstract class RoutePaths {
  RoutePaths._();

  static const String home = '/';
  static const String habitCreate = '/habit/create';
  static const String habitEdit = '/habit/:habitId/edit';
  static const String habitTimer = '/habit/:habitId/timer';
  static const String habitStats = '/habit/:habitId/stats';
  static const String habitTree = '/habit/:habitId/tree';
  static const String habitTreeGarden = '/habit-tree';
  static const String stats = '/stats';
  static const String settings = '/settings';
  static const String habitSettings = '/settings/habit/:habitId';
  static const String introduction = '/introduction';
  static const String about = '/about';

  // Helper to build parameterised paths
  static String editHabit(String habitId) => '/habit/$habitId/edit';
  static String timerForHabit(String habitId) => '/habit/$habitId/timer';
  static String statsForHabit(String habitId) => '/habit/$habitId/stats';
  static String treeForHabit(String habitId) => '/habit/$habitId/tree';
  static String settingsForHabit(String habitId) => '/settings/habit/$habitId';
}
