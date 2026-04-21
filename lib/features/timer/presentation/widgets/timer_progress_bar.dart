import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/neumorphism/neumorphic_styles.dart';

/// Neumorphic inset progress bar with green fill.
class TimerProgressBar extends StatelessWidget {
  const TimerProgressBar({
    super.key,
    required this.progress,
    this.height = 16.0,
  });

  /// 0.0 → empty, 1.0 → full.
  final double progress;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: NeumorphicStyles.inset(
        radius: 0,
      ),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (_, constraints) {
          final progressClamp = progress.clamp(0.0, 1.0);
          final fillWidth = constraints.maxWidth * progressClamp;
          final percentText = '${(progressClamp * 100).round()}%';
          final textColor = progressClamp > 0.55
              ? AppColors.onPrimary
              : AppColors.textPrimary;

          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: AppColors.surfaceElevated,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  width: fillWidth,
                  height: height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.zero,
                    gradient: LinearGradient(
                      colors: [AppColors.primaryLight, AppColors.primary],
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  percentText,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
