import 'package:flutter/material.dart';

/// Spacing, radius, shadow, and layout dimensions.
abstract class AppDimensions {
  AppDimensions._();

  // ── Spacing (8dp base grid)
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // ── Border radius
  static const double radiusXs = 8.0;
  static const double radiusSm = 12.0;
  static const double radiusMd = 16.0;
  static const double radiusLg = 24.0;
  static const double radiusRound = 50.0;

  // ── Neumorphic shadow
  static const double shadowBlurRaised = 10.0;
  static const double shadowBlurInset = 8.0;
  static const double shadowOffset = 4.0;

  // ── Component sizes
  static const double drawerWidthFraction = 0.80;
  static const double bottomSheetMinHeightFraction = 0.40;
  static const double hourglassWidth = 240.0;
  static const double hourglassHeight = 320.0;

  // ── Heatmap
  static const double heatmapCellSize = 14.0;
  static const double heatmapCellGap = 4.0;

  // ── Card
  static const double cardElevationShadow = 4.0;
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets pagePadding = EdgeInsets.all(md);

  // ── Icon sizes
  static const double iconSm = 18.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
}
