import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_text_styles.dart';
import '../../app/router/route_paths.dart';

/// Navigation drawer shared across all main pages.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.sizeOf(context).width * AppDimensions.drawerWidthFraction;

    return SizedBox(
      width: width,
      child: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.lg,
              horizontal: AppDimensions.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimensions.sm,
                    bottom: AppDimensions.lg,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.eco, color: AppColors.primary, size: 36),
                      const SizedBox(width: AppDimensions.sm),
                      Text('Kaizen AI', style: AppTextStyles.displayMedium),
                    ],
                  ),
                ),

                const Divider(),
                const SizedBox(height: AppDimensions.sm),

                const _DrawerItem(
                  icon: Icons.home_outlined,
                  label: 'Habits',
                  route: RoutePaths.home,
                ),
                const _DrawerItem(
                  icon: Icons.park_outlined,
                  label: 'Habit Tree',
                  route: RoutePaths.habitTreeGarden,
                ),
                const _DrawerItem(
                  icon: Icons.bar_chart_outlined,
                  label: 'Statistics',
                  route: RoutePaths.stats,
                ),
                const _DrawerItem(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  route: RoutePaths.settings,
                ),

                const Divider(),
                const SizedBox(height: AppDimensions.sm),

                const _DrawerItem(
                  icon: Icons.info_outline,
                  label: 'Introduction',
                  route: RoutePaths.introduction,
                ),
                const _DrawerItem(
                  icon: Icons.help_outline,
                  label: 'About',
                  route: RoutePaths.about,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    final isActive = GoRouterState.of(context).matchedLocation == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        label,
        style: AppTextStyles.titleMedium.copyWith(
          color: isActive ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
        ),
      ),
      onTap: () {
        context.go(route);
        Navigator.of(context).pop();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
      ),
      tileColor:
          isActive ? AppColors.primaryContainer.withValues(alpha: 0.4) : null,
    );
  }
}
