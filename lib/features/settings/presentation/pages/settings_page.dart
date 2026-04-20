import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_drawer.dart';

/// Settings page — global app settings. (Placeholder for Sprint 7)
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: AppTextStyles.headlineMedium),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Text('Settings — Sprint 7', style: AppTextStyles.bodyLarge),
      ),
    );
  }
}
