import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Animated hourglass using CustomPainter.
///
/// [progress] 0.0 → all sand at top; 1.0 → all sand at bottom.
/// The widget wraps a [_HourglassPainter] inside an [AnimatedBuilder]
/// for the continuous drip animation.
class HourglassAnimation extends StatefulWidget {
  const HourglassAnimation({
    super.key,
    required this.progress,
    this.width = 180.0,
    this.height = 240.0,
  });

  final double progress;
  final double width;
  final double height;

  @override
  State<HourglassAnimation> createState() => _HourglassAnimationState();
}

class _HourglassAnimationState extends State<HourglassAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _dripController;

  @override
  void initState() {
    super.initState();
    _dripController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _dripController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _dripController,
        builder: (_, __) => CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _HourglassPainter(
            progress: widget.progress,
            animValue: _dripController.value,
          ),
        ),
      ),
    );
  }
}

class _HourglassPainter extends CustomPainter {
  final double progress; // 0.0 → 1.0
  final double animValue; // 0.0 → 1.0 (drip cycle)

  _HourglassPainter({required this.progress, required this.animValue});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    // Geometry
    const neckRatio = 0.08; // neck width as fraction of total width
    final neckW = w * neckRatio;
    final neckY = h / 2; // center
    const chamberPad = 10.0;

    const topLeft = Offset(chamberPad, chamberPad);
    final topRight = Offset(w - chamberPad, chamberPad);
    final neckLeft = Offset(cx - neckW, neckY);
    final neckRight = Offset(cx + neckW, neckY);
    final botLeft = Offset(chamberPad, h - chamberPad);
    final botRight = Offset(w - chamberPad, h - chamberPad);

    // ── Hourglass outline ──────────────────────────────────────────────────
    final outlinePaint = Paint()
      ..color = AppColors.textSecondary.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final outlinePath = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..lineTo(neckRight.dx, neckRight.dy)
      ..lineTo(botRight.dx, botRight.dy)
      ..lineTo(botLeft.dx, botLeft.dy)
      ..lineTo(neckLeft.dx, neckLeft.dy)
      ..close();

    canvas.drawPath(outlinePath, outlinePaint);

    // ── Top chamber sand fill ──────────────────────────────────────────────
    // Sand starts full at progress=0; empty at progress=1.
    final topSandFraction = 1.0 - progress;

    if (topSandFraction > 0.01) {
      final topChamberH = neckY - chamberPad;
      final sandH = topChamberH * topSandFraction;
      final sandTopY = neckY - sandH;

      // The top chamber narrows toward the neck.
      // At y=chamberPad: full width = w - 2*pad
      // At y=neckY:      full width = neckW*2
      final t = 1.0 - topSandFraction; // 0 = full, 1 = empty
      final sandTopWidth = _lerp(w - 2 * chamberPad, neckW * 2, t);

      final sandPath = Path()
        ..moveTo(cx - neckW, neckY)
        ..lineTo(cx + neckW, neckY)
        ..lineTo(cx + sandTopWidth / 2, sandTopY)
        ..lineTo(cx - sandTopWidth / 2, sandTopY)
        ..close();

      final sandPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.warning.withValues(alpha: 0.7),
            AppColors.warning,
          ],
        ).createShader(Rect.fromLTWH(0, sandTopY, w, sandH));

      canvas.drawPath(sandPath, sandPaint);
    }

    // ── Bottom chamber sand fill ───────────────────────────────────────────
    if (progress > 0.01) {
      final botChamberH = h - chamberPad - neckY;
      final sandH = botChamberH * progress;
      final sandBotY = h - chamberPad - sandH;

      // The bottom chamber widens from neck toward base.
      final sandTopWidth = _lerp(neckW * 2, w - 2 * chamberPad, progress);

      final sandPath = Path()
        ..moveTo(cx - neckW, neckY)
        ..lineTo(cx + neckW, neckY)
        ..lineTo(cx + sandTopWidth / 2, sandBotY)
        ..lineTo(cx - sandTopWidth / 2, sandBotY)
        ..close();

      final botSandPath = Path()
        ..moveTo(cx - (w - 2 * chamberPad) / 2, h - chamberPad)
        ..lineTo(cx + (w - 2 * chamberPad) / 2, h - chamberPad)
        ..lineTo(cx + sandTopWidth / 2, sandBotY)
        ..lineTo(cx - sandTopWidth / 2, sandBotY)
        ..close();

      final sandPaint = Paint()
        ..color = AppColors.warning.withValues(alpha: 0.85);

      canvas.drawPath(sandPath, sandPaint);
      canvas.drawPath(botSandPath, sandPaint);
    }

    // ── Drip particles through neck ────────────────────────────────────────
    if (progress > 0.01 && progress < 0.99) {
      _drawDrip(canvas, cx, neckY, animValue);
    }

    // ── Rim caps (top and bottom horizontal bars) ──────────────────────────
    final capPaint = Paint()
      ..color = AppColors.textSecondary.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      const Offset(chamberPad - 4, chamberPad),
      Offset(w - chamberPad + 4, chamberPad),
      capPaint,
    );
    canvas.drawLine(
      Offset(chamberPad - 4, h - chamberPad),
      Offset(w - chamberPad + 4, h - chamberPad),
      capPaint,
    );
  }

  void _drawDrip(Canvas canvas, double cx, double neckY, double t) {
    final dripPaint = Paint()
      ..color = AppColors.warning
      ..style = PaintingStyle.fill;

    // 3 particles at staggered phases
    for (var i = 0; i < 3; i++) {
      final phase = (t + i * 0.33) % 1.0;
      final dy = phase * 30.0; // drip 30px below neck
      final radius = 2.5 * (1.0 - phase * 0.5);
      canvas.drawCircle(Offset(cx, neckY + dy), radius, dripPaint);
    }
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;

  @override
  bool shouldRepaint(_HourglassPainter old) =>
      old.progress != progress || old.animValue != animValue;
}

/// Converts radians to degrees (unused but kept for future polish).
// ignore: unused_element
double _toDeg(double rad) => rad * 180 / pi;
