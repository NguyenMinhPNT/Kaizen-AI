import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_paths.dart';
import '../../features/habit/presentation/pages/home_page.dart';
import '../../features/habit/presentation/pages/create_habit_page.dart';
import '../../features/habit/presentation/pages/edit_habit_page.dart';
import '../../features/timer/presentation/pages/timer_page.dart';
import '../../features/stats/presentation/pages/stats_page.dart';
import '../../features/habit_tree/presentation/pages/habit_tree_page.dart';
import '../../features/habit_tree/presentation/pages/tree_detail_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/habit_settings_page.dart';
import '../../features/settings/presentation/pages/introduction_page.dart';
import '../../features/settings/presentation/pages/about_page.dart';

final appRouter = GoRouter(
  initialLocation: RoutePaths.home,
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: RoutePaths.home,
      pageBuilder: (context, state) => _slide(state, const HomePage()),
    ),
    GoRoute(
      path: RoutePaths.habitCreate,
      pageBuilder: (context, state) => _slide(state, const CreateHabitPage()),
    ),
    GoRoute(
      path: RoutePaths.habitEdit,
      pageBuilder: (context, state) => _slide(
        state,
        EditHabitPage(habitId: state.pathParameters['habitId']!),
      ),
    ),
    GoRoute(
      path: RoutePaths.habitTimer,
      pageBuilder: (context, state) => _slide(
        state,
        TimerPage(habitId: state.pathParameters['habitId']!),
      ),
    ),
    GoRoute(
      path: RoutePaths.habitStats,
      pageBuilder: (context, state) => _slide(
        state,
        StatsPage(habitId: state.pathParameters['habitId']),
      ),
    ),
    GoRoute(
      path: RoutePaths.habitTree,
      pageBuilder: (context, state) => _slide(
        state,
        TreeDetailPage(habitId: state.pathParameters['habitId']!),
      ),
    ),
    GoRoute(
      path: RoutePaths.habitTreeGarden,
      pageBuilder: (context, state) => _slide(state, const HabitTreePage()),
    ),
    GoRoute(
      path: RoutePaths.stats,
      pageBuilder: (context, state) => _slide(state, const StatsPage()),
    ),
    GoRoute(
      path: RoutePaths.settings,
      pageBuilder: (context, state) => _slide(state, const SettingsPage()),
    ),
    GoRoute(
      path: RoutePaths.habitSettings,
      pageBuilder: (context, state) => _slide(
        state,
        HabitSettingsPage(habitId: state.pathParameters['habitId']!),
      ),
    ),
    GoRoute(
      path: RoutePaths.introduction,
      pageBuilder: (context, state) => _slide(state, const IntroductionPage()),
    ),
    GoRoute(
      path: RoutePaths.about,
      pageBuilder: (context, state) => _slide(state, const AboutPage()),
    ),
  ],
);

/// Standard slide transition from right.
CustomTransitionPage<void> _slide(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutCubic;
      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
