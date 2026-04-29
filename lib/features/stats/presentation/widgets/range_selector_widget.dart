import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/neumorphism/neumorphic_theme.dart';
import '../bloc/stats_bloc.dart';
import '../bloc/stats_event.dart';
import '../bloc/stats_state.dart';

/// 3 / 6 / 12 months dropdown that triggers a range change.
class RangeSelectorWidget extends StatelessWidget {
  const RangeSelectorWidget({super.key});

  static const _options = [3, 6, 12];
  static const _labels = ['3 Months', '6 Months', '12 Months'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        final selected =
            state is StatsDataLoaded ? state.selectedRangeMonths : 3;

        return Padding(
          padding: const EdgeInsets.only(right: AppDimensions.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                constraints: const BoxConstraints(
                  minWidth: 120,
                  maxWidth: 150,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.md,
                  vertical: AppDimensions.xs,
                ),
                decoration: context.neumorphicRaised.copyWith(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: selected,
                    isDense: true,
                    isExpanded: false,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                    dropdownColor: AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                    items: List.generate(_options.length, (i) {
                      return DropdownMenuItem<int>(
                        value: _options[i],
                        child: Text(
                          _labels[i],
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<StatsBloc>()
                            .add(StatsRangeSelected(value));
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
