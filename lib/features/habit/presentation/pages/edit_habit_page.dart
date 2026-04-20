import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Edit habit page — form to modify an existing habit. (Placeholder for Sprint 2)
class EditHabitPage extends StatelessWidget {
  const EditHabitPage({super.key, required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Habit', style: AppTextStyles.headlineMedium),
      ),
      body: Center(
        child: Text(
          'Edit Habit $habitId — Sprint 2',
          style: AppTextStyles.bodyLarge,
        ),
      ),
    );
  }
}
