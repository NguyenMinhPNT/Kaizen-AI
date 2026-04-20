import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Per-habit settings page. (Placeholder for Sprint 7)
class HabitSettingsPage extends StatelessWidget {
  const HabitSettingsPage({super.key, required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Settings', style: AppTextStyles.headlineMedium),
      ),
      body: Center(
        child: Text(
          'Settings for habit $habitId — Sprint 7',
          style: AppTextStyles.bodyLarge,
        ),
      ),
    );
  }
}
