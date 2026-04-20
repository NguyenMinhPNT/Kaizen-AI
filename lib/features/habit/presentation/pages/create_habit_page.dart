import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Create habit page — form to add a new habit. (Placeholder for Sprint 2)
class CreateHabitPage extends StatelessWidget {
  const CreateHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Habit', style: AppTextStyles.headlineMedium),
      ),
      body: Center(
        child: Text(
          'Create Habit — Sprint 2',
          style: AppTextStyles.bodyLarge,
        ),
      ),
    );
  }
}
