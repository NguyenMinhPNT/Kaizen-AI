import 'package:flutter/material.dart';
import '../theme/neumorphism/neumorphic_theme.dart';
import '../theme/app_dimensions.dart';

/// A neumorphic container — the building block for all neumorphic surfaces.
/// Renders as raised (elevated) or inset (concave) based on [isInset].
class NeumorphicContainer extends StatelessWidget {
  const NeumorphicContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.isInset = false,
  });

  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final bool isInset;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppDimensions.radiusMd;
    final decoration =
        isInset ? context.neumorphicInset : context.neumorphicRaised;

    // Apply custom radius if provided
    final resolvedDecoration = borderRadius != null
        ? (context.brightness == Brightness.dark
            ? decoration.copyWith(
                borderRadius: BorderRadius.circular(radius),
              )
            : decoration.copyWith(
                borderRadius: BorderRadius.circular(radius),
              ))
        : decoration;

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? AppDimensions.cardPadding,
      decoration: resolvedDecoration,
      child: child,
    );
  }
}

extension on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;
}
