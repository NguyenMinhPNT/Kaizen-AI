import 'package:flutter/material.dart';
import '../theme/neumorphism/neumorphic_theme.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_text_styles.dart';

/// A neumorphic button that toggles between raised (normal) and inset (pressed).
class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height = 52.0,
    this.borderRadius,
    this.isPressed = false,
    this.surfaceColor,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final double height;
  final double? borderRadius;
  final bool isPressed;
  final Color? surfaceColor;

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    final pressed = _isDown || widget.isPressed;
    final radius = widget.borderRadius ?? AppDimensions.radiusRound;
    var decoration =
        (pressed ? context.neumorphicInset : context.neumorphicRaised)
            .copyWith(borderRadius: BorderRadius.circular(radius));

    if (widget.surfaceColor != null) {
      decoration = decoration.copyWith(color: widget.surfaceColor);
    }

    return GestureDetector(
      onTapDown: widget.onPressed != null
          ? (_) => setState(() => _isDown = true)
          : null,
      onTapUp: widget.onPressed != null
          ? (_) {
              setState(() => _isDown = false);
              widget.onPressed!();
            }
          : null,
      onTapCancel: () => setState(() => _isDown = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width,
        height: widget.height,
        decoration: decoration,
        child: Center(child: widget.child),
      ),
    );
  }
}

/// A circular neumorphic icon button.
class NeumorphicIconButton extends StatelessWidget {
  const NeumorphicIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 52.0,
    this.iconColor,
    this.backgroundColor,
    this.borderRadius,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      width: size,
      height: size,
      borderRadius: borderRadius ?? AppDimensions.radiusRound,
      surfaceColor: backgroundColor,
      child: Icon(
        icon,
        color: iconColor ?? AppColors.textPrimary,
        size: AppDimensions.iconLg,
      ),
    );
  }
}

/// A pre-styled primary neumorphic button with a text label.
class NeumorphicTextButton extends StatelessWidget {
  const NeumorphicTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.icon,
    this.isPrimary = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final IconData? icon;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon,
                color: isPrimary ? AppColors.primary : AppColors.textPrimary,
                size: AppDimensions.iconMd),
            const SizedBox(width: AppDimensions.xs),
          ],
          Text(
            label,
            style: AppTextStyles.labelLarge.copyWith(
              color: isPrimary ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
