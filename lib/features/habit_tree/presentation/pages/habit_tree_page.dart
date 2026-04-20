import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_drawer.dart';

/// Habit Tree garden page — shows all trees. (Placeholder for Sprint 6)
class HabitTreePage extends StatelessWidget {
  const HabitTreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tree', style: AppTextStyles.headlineMedium),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Text('Habit Tree Garden — Sprint 6',
            style: AppTextStyles.bodyLarge),
      ),
    );
  }
}
