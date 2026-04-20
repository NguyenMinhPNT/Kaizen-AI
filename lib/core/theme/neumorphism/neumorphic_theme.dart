import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'neumorphic_styles.dart';

/// Extension on [BuildContext] to access neumorphic decorations
/// that automatically adapt to the current brightness.
extension NeumorphicTheme on BuildContext {
  bool get _isDark => Theme.of(this).brightness == Brightness.dark;

  BoxDecoration get neumorphicRaised =>
      _isDark ? NeumorphicStyles.raisedDark() : NeumorphicStyles.raised();

  BoxDecoration get neumorphicInset =>
      _isDark ? NeumorphicStyles.insetDark() : NeumorphicStyles.inset();

  BoxDecoration get neumorphicRaisedButton => _isDark
      ? NeumorphicStyles.raisedDark(radius: 50)
      : NeumorphicStyles.raisedButton();

  BoxDecoration get neumorphicInsetButton => _isDark
      ? NeumorphicStyles.insetDark(radius: 50)
      : NeumorphicStyles.insetButton();

  Color get neumorphicSurface =>
      _isDark ? AppColors.surfaceBaseDark : AppColors.surfaceBase;

  Color get neumorphicSurfaceElevated =>
      _isDark ? AppColors.surfaceElevatedDark : AppColors.surfaceElevated;
}
