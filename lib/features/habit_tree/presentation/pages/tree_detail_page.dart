import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Tree detail page — full tree view for one habit. (Placeholder for Sprint 6)
class TreeDetailPage extends StatelessWidget {
  const TreeDetailPage({super.key, required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tree', style: AppTextStyles.headlineMedium),
      ),
      body: Center(
        child: Text(
          'Tree detail for habit $habitId — Sprint 6',
          style: AppTextStyles.bodyLarge,
        ),
      ),
    );
  }
}
