import 'package:flutter/material.dart';

/// Kaizen AI color palette.
abstract class AppColors {
  AppColors._();

  // ── Surface / Background (60%)
  static const Color surfaceBase = Color(0xFFEEF2EE);
  static const Color surfaceElevated = Color(0xFFF5F7F5);
  static const Color shadowLight = Color(0xFFFFFFFF);
  static const Color shadowDark = Color(0xFFC8D4C8);

  // ── Brand Green (30%)
  static const Color primary = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF388E3C);
  static const Color primaryLight = Color(0xFF81C784);
  static const Color primaryContainer = Color(0xFFC8E6C9);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // ── Semantic (10%)
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF6AD55);
  static const Color danger = Color(0xFFE53E3E);
  static const Color missed = Color(0xFF2D3748);

  static const Color textPrimary = Color(0xFF1A2E1A);
  static const Color textSecondary = Color(0xFF4A6B4A);
  static const Color textHint = Color(0xFF90A090);

  // ── Heatmap red spectrum (completed days)
  static const Color heatLevel1 = Color(0xFFFED7D7);
  static const Color heatLevel2 = Color(0xFFFEB2B2);
  static const Color heatLevel3 = Color(0xFFFC8181);
  static const Color heatLevel4 = Color(0xFFF56565);
  static const Color heatLevel5 = Color(0xFFE53E3E);
  static const Color heatLevel6 = Color(0xFF9B2C2C);

  static const List<Color> heatLevels = [
    heatLevel1,
    heatLevel2,
    heatLevel3,
    heatLevel4,
    heatLevel5,
    heatLevel6,
  ];

  // ── Dark theme equivalents
  static const Color surfaceBaseDark = Color(0xFF1E2A1E);
  static const Color surfaceElevatedDark = Color(0xFF253225);
  static const Color shadowLightDark = Color(0xFF2C3F2C);
  static const Color shadowDarkDark = Color(0xFF131C13);

  static const Color textPrimaryDark = Color(0xFFE8F5E9);
  static const Color textSecondaryDark = Color(0xFFA5D6A7);
  static const Color textHintDark = Color(0xFF558B5A);
}
