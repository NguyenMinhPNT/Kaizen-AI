import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Large monospace countdown display — MM:SS format.
class CountdownDisplay extends StatelessWidget {
  const CountdownDisplay({
    super.key,
    required this.remainingSeconds,
    this.isDanger = false,
  });

  final int remainingSeconds;

  /// Turns red when under 60 seconds remaining.
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final m = remainingSeconds ~/ 60;
    final s = remainingSeconds % 60;
    final text =
        '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';

    final color = isDanger ? AppColors.danger : AppColors.textPrimary;

    return Text(
      text,
      style: AppTextStyles.monoLarge.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
