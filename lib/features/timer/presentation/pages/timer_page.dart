import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../habit/domain/entities/habit_entity.dart';
import '../../../habit/domain/enums/habit_status.dart';
import '../../../habit/domain/repositories/habit_repository.dart';
import '../../../habit/domain/usecases/get_habit_by_id_usecase.dart';
import '../bloc/timer_bloc.dart';
import '../bloc/timer_event.dart';
import '../bloc/timer_state.dart';
import '../widgets/countdown_display.dart';
import '../widgets/timer_action_buttons.dart';
import '../widgets/timer_progress_bar.dart';

/// Entry point for the Timer feature.
///
/// Loads the [HabitEntity] from DI then provides a [TimerBloc].
class TimerPage extends StatefulWidget {
  const TimerPage({super.key, required this.habitId});

  final String habitId;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with WidgetsBindingObserver {
  late final TimerBloc _timerBloc;
  HabitEntity? _habit;
  bool _loading = true;
  String? _error;
  bool _isLockedToday = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _timerBloc = getIt<TimerBloc>();
    _loadHabit();
  }

  Future<void> _loadHabit() async {
    try {
      final habit = await getIt<GetHabitByIdUseCase>()(widget.habitId);
      final status =
          await getIt<HabitRepository>().getTodayStatus(widget.habitId);
      if (mounted) {
        setState(() {
          _habit = habit;
          _loading = false;
          _error = habit == null ? 'Habit not found.' : null;
          _isLockedToday =
              status == HabitStatus.completed || status == HabitStatus.gaveUp;
        });

        if (habit != null) {
          _timerBloc.add(TimerRestoreEvent(
            habitId: habit.id,
            habitName: habit.name,
            targetSeconds: habit.currentDurationMinutes * 60,
          ));
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = e.toString();
          _isLockedToday = false;
        });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _pauseIfRunning();
    }
  }

  void _pauseIfRunning() {
    final blocState = _timerBloc.state;
    if (blocState is TimerRunningState) {
      _timerBloc.add(const TimerPausedEvent());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pauseIfRunning();
    _timerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.surfaceBase,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null || _habit == null) {
      return Scaffold(
        backgroundColor: AppColors.surfaceBase,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceBase,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.textPrimary),
        ),
        body: Center(
          child: Text(_error ?? 'Habit not found.',
              style: AppTextStyles.bodyLarge),
        ),
      );
    }

    return BlocProvider.value(
      value: _timerBloc,
      child: _TimerView(
        habit: _habit!,
        isLockedToday: _isLockedToday,
      ),
    );
  }
}

// ─── Internal view ────────────────────────────────────────────────────────────

class _TimerView extends StatelessWidget {
  const _TimerView({required this.habit, required this.isLockedToday});
  final HabitEntity habit;
  final bool isLockedToday;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceBase,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Column(
          children: [
            Text(habit.name, style: AppTextStyles.headlineMedium),
            Text(
              '${habit.currentDurationMinutes} min session',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<TimerBloc, TimerState>(
        listener: (context, state) {
          if (state is TimerFinishedState) {
            _showFinishedSnackbar(context);
          } else if (state is TimerGaveUpState) {
            _showGaveUpSnackbar(context, state.completionPct);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.lg,
                vertical: AppDimensions.md,
              ),
              child: Column(
                children: [
                  const Spacer(),

                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountdownDisplay(
                            remainingSeconds: _remainingOf(
                              state,
                              habit.currentDurationMinutes * 60,
                            ),
                            isDanger: _isDanger(state),
                          ),
                          if (isLockedToday && state is TimerInitialState) ...[
                            const SizedBox(height: AppDimensions.sm),
                            Text(
                              'Session ended today. Start Timer unlocks at midnight.',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          const SizedBox(height: AppDimensions.lg),
                          SizedBox(
                            width: double.infinity,
                            child: TimerProgressBar(
                              progress: _progressOf(state),
                              height: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // ── Action buttons ────────────────────────────────────────
                  TimerActionButtons(
                    state: state,
                    isLockedToday: isLockedToday,
                    onStart: () => context.read<TimerBloc>().add(
                          TimerStarted(
                            habitId: habit.id,
                            habitName: habit.name,
                            targetSeconds: habit.currentDurationMinutes * 60,
                          ),
                        ),
                    onPause: () =>
                        context.read<TimerBloc>().add(const TimerPausedEvent()),
                    onResume: () => context
                        .read<TimerBloc>()
                        .add(const TimerResumedEvent()),
                    onGiveUp: () => _confirmGiveUp(context),
                    onDone: () => context.pop(),
                  ),

                  const SizedBox(height: AppDimensions.lg),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────────────────

  double _progressOf(TimerState state) => switch (state) {
        TimerRunningState(progress: final p) => p,
        TimerPausedState(progress: final p) => p,
        TimerFinishedState() => 1.0,
        _ => 0.0,
      };

  int _remainingOf(TimerState state, int defaultTarget) => switch (state) {
        TimerRunningState(remaining: final r) => r,
        TimerPausedState(remaining: final r) => r,
        TimerFinishedState() => 0,
        _ => defaultTarget,
      };

  bool _isDanger(TimerState state) => switch (state) {
        TimerRunningState(remaining: final r) => r <= 60,
        TimerPausedState(remaining: final r) => r <= 60,
        _ => false,
      };

  void _confirmGiveUp(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surfaceBase,
        title: Text('Give Up?', style: AppTextStyles.headlineMedium),
        content: Text(
          'Progress will be saved as a partial session.',
          style: AppTextStyles.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Keep going',
              style:
                  AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<TimerBloc>().add(const TimerGaveUpEvent());
            },
            child: Text(
              'Give Up',
              style: AppTextStyles.labelLarge.copyWith(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }

  void _showFinishedSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Session complete! Great work on ${habit.name}',
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.onPrimary),
        ),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showGaveUpSnackbar(BuildContext context, double completionPct) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Session ended — ${completionPct.toStringAsFixed(0)}% completed',
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.onPrimary),
        ),
        backgroundColor: AppColors.warning,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
