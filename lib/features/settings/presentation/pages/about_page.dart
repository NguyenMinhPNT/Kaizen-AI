import 'package:flutter/material.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_drawer.dart';

/// About page — app version and credits. (Placeholder for Sprint 7)
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About', style: AppTextStyles.headlineMedium),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.eco, size: 64, color: AppColors.primary),
              const SizedBox(height: AppDimensions.lg),
              Text('Kaizen AI', style: AppTextStyles.displayMedium),
              const SizedBox(height: AppDimensions.xs),
              Text('Version 1.0.0', style: AppTextStyles.bodyMedium),
              const SizedBox(height: AppDimensions.lg),
              Text(
                'Built with Flutter & Kaizen philosophy.\n'
                '"Every day, a little better."',
                style: AppTextStyles.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
