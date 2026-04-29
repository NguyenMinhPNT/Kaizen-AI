import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/widgets/neumorphic_button.dart';

/// Settings page — global app settings. (Placeholder for Sprint 7)
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
          child: Builder(
            builder: (ctx) => NeumorphicIconButton(
              icon: Icons.menu,
              iconColor: AppColors.primary,
              backgroundColor: AppColors.surfaceElevated,
              onPressed: () => Scaffold.of(ctx).openDrawer(),
              size: 46,
            ),
          ),
        ),
        title: Text(
          'Settings',
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Angkor',
          ),
        ),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Text('Settings — Sprint 7', style: AppTextStyles.bodyLarge),
      ),
    );
  }
}
