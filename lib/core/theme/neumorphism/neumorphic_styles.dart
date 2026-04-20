import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_dimensions.dart';

/// Factory functions for neumorphic BoxDecoration styles.
abstract class NeumorphicStyles {
  NeumorphicStyles._();

  // ── Light theme raised (default elevated surface)
  static BoxDecoration raised({
    double radius = AppDimensions.radiusMd,
    Color surface = AppColors.surfaceBase,
  }) =>
      BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight.withValues(alpha: 0.8),
            offset: const Offset(
                -AppDimensions.shadowOffset, -AppDimensions.shadowOffset),
            blurRadius: AppDimensions.shadowBlurRaised,
          ),
          BoxShadow(
            color: AppColors.shadowDark.withValues(alpha: 0.6),
            offset: const Offset(
                AppDimensions.shadowOffset, AppDimensions.shadowOffset),
            blurRadius: AppDimensions.shadowBlurRaised,
          ),
        ],
      );

  // ── Light theme inset / pressed
  static BoxDecoration inset({
    double radius = AppDimensions.radiusMd,
    Color surface = AppColors.surfaceBase,
  }) =>
      BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark.withValues(alpha: 0.6),
            offset: const Offset(
                -AppDimensions.shadowOffset, -AppDimensions.shadowOffset),
            blurRadius: AppDimensions.shadowBlurInset,
          ),
          BoxShadow(
            color: AppColors.shadowLight.withValues(alpha: 0.8),
            offset: const Offset(
                AppDimensions.shadowOffset, AppDimensions.shadowOffset),
            blurRadius: AppDimensions.shadowBlurInset,
          ),
        ],
      );

  // ── Dark theme raised
  static BoxDecoration raisedDark({
    double radius = AppDimensions.radiusMd,
    Color surface = AppColors.surfaceBaseDark,
  }) =>
      BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLightDark.withValues(alpha: 0.5),
            offset: const Offset(
                -AppDimensions.shadowOffset, -AppDimensions.shadowOffset),
            blurRadius: AppDimensions.shadowBlurRaised,
          ),
          BoxShadow(
            color: AppColors.shadowDarkDark.withValues(alpha: 0.8),
            offset: const Offset(
                AppDimensions.shadowOffset, AppDimensions.shadowOffset),
            blurRadius: AppDimensions.shadowBlurRaised,
          ),
        ],
      );

  // ── Dark theme inset
  static BoxDecoration insetDark({
    double radius = AppDimensions.radiusMd,
    Color surface = AppColors.surfaceBaseDark,
  }) =>
      BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDarkDark.withValues(alpha: 0.8),
            offset: const Offset(
                -AppDimensions.shadowOffset, -AppDimensions.shadowOffset),
            blurRadius: AppDimensions.shadowBlurInset,
          ),
          BoxShadow(
            color: AppColors.shadowLightDark.withValues(alpha: 0.5),
            offset: const Offset(
                AppDimensions.shadowOffset, AppDimensions.shadowOffset),
            blurRadius: AppDimensions.shadowBlurInset,
          ),
        ],
      );

  // ── Button (circular/pill shaped)
  static BoxDecoration raisedButton({
    Color surface = AppColors.surfaceBase,
  }) =>
      raised(radius: AppDimensions.radiusRound, surface: surface);

  static BoxDecoration insetButton({
    Color surface = AppColors.surfaceBase,
  }) =>
      inset(radius: AppDimensions.radiusRound, surface: surface);
}
