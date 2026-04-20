import 'package:flutter/material.dart';
import '../theme/neumorphism/neumorphic_theme.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

/// A neumorphic slider with an inset track and a raised thumb.
class NeumorphicSlider extends StatelessWidget {
  const NeumorphicSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
    this.activeColor = AppColors.primary,
  });

  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final int? divisions;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.sm),
      decoration: context.neumorphicInset.copyWith(
        borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
      ),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: activeColor,
          inactiveTrackColor: Colors.transparent,
          thumbColor: activeColor,
          overlayColor: activeColor.withValues(alpha: 0.2),
          trackHeight: 4,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        ),
        child: Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
