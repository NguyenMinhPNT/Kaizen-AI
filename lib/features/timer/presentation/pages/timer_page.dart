import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Timer page — countdown timer for a habit session. (Placeholder for Sprint 3)
class TimerPage extends StatelessWidget {
  const TimerPage({super.key, required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer', style: AppTextStyles.headlineMedium),
      ),
      body: Center(
        child: Text(
          'Timer for habit $habitId — Sprint 3',
          style: AppTextStyles.bodyLarge,
        ),
      ),
    );
  }
}
