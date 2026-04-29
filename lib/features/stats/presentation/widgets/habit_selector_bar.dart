import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/neumorphism/neumorphic_theme.dart';
import '../../../habit/domain/entities/habit_entity.dart';
import '../bloc/stats_bloc.dart';
import '../bloc/stats_event.dart';
import '../bloc/stats_state.dart';

/// Scrollable row of chips — one per habit. Tapping a chip re-queries stats.
class HabitSelectorBar extends StatelessWidget {
  const HabitSelectorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is! StatsDataLoaded) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.md,
                  vertical: AppDimensions.xs,
                ),
                decoration: context.neumorphicRaised.copyWith(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusRound),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: state.selectedHabitId,
                    dropdownColor: context.neumorphicSurface,
                    elevation: 2,
                    iconEnabledColor: AppColors.textSecondary,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    items: state.habits.map((habit) {
                      final color = Color(
                        int.parse(habit.colorHex.replaceFirst('#', '0xFF')),
                      );
                      return DropdownMenuItem(
                        value: habit.id,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              IconData(habit.iconCode,
                                  fontFamily: 'MaterialIcons'),
                              size: AppDimensions.iconSm,
                              color: color,
                            ),
                            const SizedBox(width: AppDimensions.xs),
                            Text(habit.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (habitId) {
                      if (habitId != null) {
                        context
                            .read<StatsBloc>()
                            .add(StatsHabitSelected(habitId));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HabitChip extends StatelessWidget {
  const _HabitChip({
    required this.habit,
    required this.isSelected,
    required this.onTap,
  });

  final HabitEntity habit;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(habit.colorHex.replaceFirst('#', '0xFF')));

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: isSelected
            ? context.neumorphicInset.copyWith(
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
              )
            : context.neumorphicRaised.copyWith(
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
              ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.md,
          vertical: AppDimensions.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              IconData(habit.iconCode, fontFamily: 'MaterialIcons'),
              size: AppDimensions.iconSm,
              color: isSelected ? color : AppColors.textSecondary,
            ),
            const SizedBox(width: AppDimensions.xs),
            Text(
              habit.name,
              style: AppTextStyles.labelLarge.copyWith(
                color: isSelected ? AppColors.textPrimary : AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
