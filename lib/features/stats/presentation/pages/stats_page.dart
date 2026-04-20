import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_drawer.dart';

/// Stats page — heatmap and bar chart for habit statistics. (Placeholder for Sprint 4)
class StatsPage extends StatelessWidget {
  const StatsPage({super.key, this.habitId});

  final String? habitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics', style: AppTextStyles.headlineMedium),
      ),
      drawer: habitId == null ? const AppDrawer() : null,
      body: Center(
        child: Text(
          habitId != null
              ? 'Stats for habit $habitId — Sprint 4'
              : 'Statistics — Sprint 4',
          style: AppTextStyles.bodyLarge,
        ),
      ),
    );
  }
}
