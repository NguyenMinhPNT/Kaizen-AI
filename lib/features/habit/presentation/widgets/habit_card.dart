import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/color_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/neumorphism/neumorphic_theme.dart';
import '../../../../core/widgets/neumorphic_button.dart';
import '../../../../app/di/injection_container.dart';
import '../../../../app/router/route_paths.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/enums/habit_status.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../../timer/domain/entities/timer_session.dart';
import '../../../timer/domain/repositories/timer_repository.dart';
import '../bloc/habit_list_bloc.dart';
import '../bloc/habit_list_event.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({super.key, required this.habit});

  final HabitEntity habit;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(habit.id),
      background: _swipeBackground(
        context,
        alignment: Alignment.centerLeft,
        color: AppColors.warning.withValues(alpha: 0.8),
        icon: Icons.archive_outlined,
        label: 'Archive',
      ),
      secondaryBackground: _swipeBackground(
        context,
        alignment: Alignment.centerRight,
        color: AppColors.danger.withValues(alpha: 0.8),
        icon: Icons.delete_outline,
        label: 'Delete',
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          context.read<HabitListBloc>().add(ArchiveHabitEvent(habit.id));
          return false; // stream will update the list
        } else {
          return await _confirmDelete(context);
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          context.read<HabitListBloc>().add(DeleteHabitEvent(habit.id));
        }
      },
      child: _CardContent(habit: habit),
    );
  }

  Widget _swipeBackground(
    BuildContext context, {
    required AlignmentGeometry alignment,
    required Color color,
    required IconData icon,
    required String label,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppDimensions.xs,
        horizontal: AppDimensions.md,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: AppDimensions.iconLg),
          const SizedBox(height: AppDimensions.xs),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) => showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Delete habit?', style: AppTextStyles.titleMedium),
          content: Text(
            'This will permanently delete "${habit.name}" and all its history.',
            style: AppTextStyles.bodyMedium,
          ),
          actions: [
            NeumorphicTextButton(
              label: 'Cancel',
              onPressed: () => Navigator.of(context).pop(false),
              width: 100,
              isPrimary: false,
            ),
            NeumorphicTextButton(
              label: 'Delete',
              onPressed: () => Navigator.of(context).pop(true),
              width: 100,
              icon: Icons.delete_outline,
              isPrimary: false,
            ),
          ],
        ),
      );
}

class _CardContent extends StatelessWidget {
  const _CardContent({required this.habit});
  final HabitEntity habit;

  @override
  Widget build(BuildContext context) {
    final habitColor = ColorExtensions.fromHex(habit.colorHex);
    final cardBackgroundColor = habitColor.withValues(alpha: 0.18);

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppDimensions.xs,
        horizontal: AppDimensions.md,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.md,
        horizontal: AppDimensions.md,
      ),
      decoration: context.neumorphicRaised.copyWith(
        color: cardBackgroundColor,
      ),
      child: Row(
        children: [
          // Colored circle avatar
          _HabitAvatar(habitColor: habitColor, iconCode: habit.iconCode),
          const SizedBox(width: AppDimensions.md),
          // Name + stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit.name,
                  style: AppTextStyles.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimensions.xs),
                _StatsRow(habit: habit, habitColor: habitColor),
              ],
            ),
          ),
          // Three-dot menu
          _HabitMenu(habit: habit),
        ],
      ),
    );
  }
}

class _HabitAvatar extends StatelessWidget {
  const _HabitAvatar({
    required this.habitColor,
    required this.iconCode,
  });
  final Color habitColor;
  final int iconCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: habitColor.withValues(alpha: 0.15),
        border: Border.all(color: habitColor.withValues(alpha: 0.4), width: 2),
      ),
      child: Center(
        child: Icon(
          IconData(iconCode, fontFamily: 'MaterialIcons'),
          color: Colors.black,
          size: AppDimensions.iconMd,
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.habit, required this.habitColor});
  final HabitEntity habit;
  final Color habitColor;

  Future<bool> _shouldShowPauseLabel() async {
    final session = getIt<TimerRepository>().recoverSession();
    if (session == null || session.status != TimerStatus.paused) {
      return false;
    }
    if (session.habitId != habit.id) {
      return false;
    }

    final status = await getIt<HabitRepository>().getTodayStatus(habit.id);
    return status != HabitStatus.completed && status != HabitStatus.gaveUp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _shouldShowPauseLabel(),
      builder: (context, snapshot) {
        final showPause = snapshot.data == true;
        return Row(
          children: [
            _Chip(
              icon: Icons.timer_outlined,
              label: '${habit.currentDurationMinutes} min',
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppDimensions.sm),
            _Chip(
              icon: Icons.local_fire_department_outlined,
              label: '${habit.currentStreak}d',
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: AppDimensions.sm),
            _Chip(
              icon: Icons.check_circle_outline,
              label: '${habit.totalCompletedDays}',
              color: AppColors.success,
            ),
            if (showPause) ...[
              const SizedBox(width: AppDimensions.sm),
              Text(
                'Pause',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 2),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _HabitMenu extends StatefulWidget {
  const _HabitMenu({required this.habit});
  final HabitEntity habit;

  @override
  State<_HabitMenu> createState() => _HabitMenuState();
}

class _HabitMenuState extends State<_HabitMenu> {
  late final Future<HabitStatus?> _todayStatusFuture;

  @override
  void initState() {
    super.initState();
    _todayStatusFuture =
        getIt<HabitRepository>().getTodayStatus(widget.habit.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HabitStatus?>(
      future: _todayStatusFuture,
      builder: (context, snapshot) {
        final isLocked = snapshot.data == HabitStatus.completed ||
            snapshot.data == HabitStatus.gaveUp;
        return PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.textSecondary,
            size: AppDimensions.iconMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          color: context.neumorphicSurface,
          onSelected: (value) => _handleMenuAction(context, value, isLocked),
          itemBuilder: (_) => [
            _menuItem(
              Icons.play_arrow_outlined,
              isLocked ? 'Start Timer (locked)' : 'Start Timer',
              'timer',
              color: isLocked ? AppColors.textHint : null,
              enabled: !isLocked,
            ),
            _menuItem(Icons.edit_outlined, 'Edit', 'edit'),
            _menuItem(Icons.trending_up_outlined, 'Level Up', 'levelUp'),
            _menuItem(Icons.trending_down_outlined, 'Level Down', 'levelDown'),
            _menuItem(Icons.archive_outlined, 'Archive', 'archive'),
            _menuItem(Icons.delete_outline, 'Delete', 'delete',
                color: AppColors.danger),
          ],
        );
      },
    );
  }

  void _handleMenuAction(BuildContext context, String action, bool isLocked) {
    if (action == 'timer' && isLocked) return;
    final bloc = context.read<HabitListBloc>();
    switch (action) {
      case 'timer':
        context.push(RoutePaths.timerForHabit(widget.habit.id));
        return;
      case 'edit':
        context.push(RoutePaths.editHabit(widget.habit.id));
        return;
      case 'levelUp':
        bloc.add(LevelUpHabitEvent(widget.habit.id));
        return;
      case 'levelDown':
        bloc.add(LevelDownHabitEvent(widget.habit.id));
        return;
      case 'archive':
        bloc.add(ArchiveHabitEvent(widget.habit.id));
        return;
      case 'delete':
        bloc.add(DeleteHabitEvent(widget.habit.id));
        return;
    }
  }

  PopupMenuItem<String> _menuItem(
    IconData icon,
    String label,
    String value, {
    Color? color,
    bool enabled = true,
  }) {
    final c = color ?? AppColors.textPrimary;
    return PopupMenuItem(
      value: value,
      enabled: enabled,
      child: Row(
        children: [
          Icon(icon, size: AppDimensions.iconMd, color: c),
          const SizedBox(width: AppDimensions.sm),
          Text(label, style: AppTextStyles.bodyLarge.copyWith(color: c)),
        ],
      ),
    );
  }
}
