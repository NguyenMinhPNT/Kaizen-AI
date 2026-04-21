import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/neumorphic_button.dart';
import '../bloc/timer_state.dart';

/// Renders the correct set of action buttons based on the current [TimerState].
class TimerActionButtons extends StatelessWidget {
  const TimerActionButtons({
    super.key,
    required this.state,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onGiveUp,
    required this.onDone,
    this.isLockedToday = false,
  });

  final TimerState state;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onGiveUp;
  final VoidCallback onDone;
  final bool isLockedToday;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      TimerInitialState() => _TapToStart(
          onStart: isLockedToday ? null : onStart,
          label: isLockedToday ? 'Locked until midnight' : 'Tap to Start',
        ),
      TimerRunningState() => _RunningButtons(
          onPause: onPause,
          onGiveUp: onGiveUp,
        ),
      TimerPausedState() => _PausedButtons(
          onResume: onResume,
          onGiveUp: onGiveUp,
        ),
      TimerFinishedState() => _FullWidthButton(
          label: 'Done',
          icon: Icons.check_circle_outline,
          color: AppColors.success,
          onPressed: onDone,
        ),
      TimerGaveUpState() => _FullWidthButton(
          label: 'Back',
          icon: Icons.arrow_back_ios_new,
          color: AppColors.textSecondary,
          onPressed: onDone,
        ),
      TimerErrorState() => _FullWidthButton(
          label: 'Back',
          icon: Icons.arrow_back_ios_new,
          color: AppColors.textSecondary,
          onPressed: onDone,
        ),
    };
  }
}

// ─── Button variants ─────────────────────────────────────────────────────────

class _TapToStart extends StatelessWidget {
  const _TapToStart({required this.onStart, required this.label});
  final VoidCallback? onStart;
  final String label;

  @override
  Widget build(BuildContext context) {
    final enabled = onStart != null;
    return NeumorphicButton(
      onPressed: onStart,
      width: double.infinity,
      height: 60.0,
      borderRadius: AppDimensions.radiusRound,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.play_arrow_rounded,
            color: enabled ? AppColors.primary : AppColors.textHint,
            size: 28,
          ),
          const SizedBox(width: AppDimensions.sm),
          Text(
            label,
            style: AppTextStyles.labelLarge.copyWith(
              color: enabled ? AppColors.primary : AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}

class _RunningButtons extends StatelessWidget {
  const _RunningButtons({required this.onPause, required this.onGiveUp});
  final VoidCallback onPause;
  final VoidCallback onGiveUp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: NeumorphicButton(
            onPressed: onPause,
            height: 56.0,
            borderRadius: AppDimensions.radiusRound,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.pause_rounded,
                    color: AppColors.primary, size: 24),
                const SizedBox(width: AppDimensions.xs),
                Text('Pause',
                    style: AppTextStyles.labelLarge
                        .copyWith(color: AppColors.primary)),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.md),
        Expanded(
          flex: 2,
          child: _GiveUpButton(onGiveUp: onGiveUp),
        ),
      ],
    );
  }
}

class _PausedButtons extends StatelessWidget {
  const _PausedButtons({required this.onResume, required this.onGiveUp});
  final VoidCallback onResume;
  final VoidCallback onGiveUp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: NeumorphicButton(
            onPressed: onResume,
            height: 56.0,
            borderRadius: AppDimensions.radiusRound,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.play_arrow_rounded,
                    color: AppColors.primary, size: 24),
                const SizedBox(width: AppDimensions.xs),
                Text('Resume',
                    style: AppTextStyles.labelLarge
                        .copyWith(color: AppColors.primary)),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.md),
        Expanded(
          flex: 2,
          child: _GiveUpButton(onGiveUp: onGiveUp),
        ),
      ],
    );
  }
}

class _GiveUpButton extends StatelessWidget {
  const _GiveUpButton({required this.onGiveUp});
  final VoidCallback onGiveUp;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onGiveUp,
      height: 56.0,
      borderRadius: AppDimensions.radiusRound,
      child: Text(
        'Give Up',
        style: AppTextStyles.labelLarge.copyWith(color: AppColors.danger),
      ),
    );
  }
}

class _FullWidthButton extends StatelessWidget {
  const _FullWidthButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      width: double.infinity,
      height: 60.0,
      borderRadius: AppDimensions.radiusRound,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: AppDimensions.sm),
          Text(label, style: AppTextStyles.labelLarge.copyWith(color: color)),
        ],
      ),
    );
  }
}
