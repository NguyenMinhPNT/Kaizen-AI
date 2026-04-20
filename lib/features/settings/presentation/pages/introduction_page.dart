import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/widgets/neumorphic_button.dart';

/// Introduction / onboarding page — explains Kaizen philosophy. (Placeholder for Sprint 7)
class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Introduction', style: AppTextStyles.headlineMedium),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.eco, size: 80, color: AppColors.primary),
                const SizedBox(height: AppDimensions.lg),
                Text('Kaizen AI', style: AppTextStyles.displayLarge),
                const SizedBox(height: AppDimensions.sm),
                Text(
                  'Change for the better, one day at a time.',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.lg),
                Text(
                  'Build life-changing habits through small,\n'
                  'consistent, daily improvements.\n\n'
                  'Every day, a little better. 🌱',
                  style: AppTextStyles.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.xxl),
                NeumorphicTextButton(
                  label: "Let's Begin",
                  onPressed: () => Navigator.of(context).pop(),
                  width: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
