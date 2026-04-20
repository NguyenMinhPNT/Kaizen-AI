import 'package:flutter/material.dart';
import '../theme/neumorphism/neumorphic_theme.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

/// A neumorphic toggle switch between two options.
class NeumorphicToggle extends StatelessWidget {
  const NeumorphicToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = AppColors.primary,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 56,
        height: 28,
        decoration: (value ? context.neumorphicInset : context.neumorphicRaised)
            .copyWith(
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound)),
        padding: const EdgeInsets.all(3),
        child: Stack(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value ? activeColor : AppColors.textHint,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowDark.withValues(alpha: 0.4),
                    blurRadius: 4,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
