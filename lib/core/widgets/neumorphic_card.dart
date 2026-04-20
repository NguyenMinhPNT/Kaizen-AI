import 'package:flutter/material.dart';
import '../theme/neumorphism/neumorphic_theme.dart';
import '../theme/app_dimensions.dart';

/// A neumorphic card — raised surface with standard card padding and radius.
class NeumorphicCard extends StatelessWidget {
  const NeumorphicCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppDimensions.radiusMd;

    Widget card = Container(
      margin: margin,
      padding: padding ?? AppDimensions.cardPadding,
      decoration: context.neumorphicRaised.copyWith(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );

    if (onTap != null) {
      card = GestureDetector(onTap: onTap, child: card);
    }

    return card;
  }
}
