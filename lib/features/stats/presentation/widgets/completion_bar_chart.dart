import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/neumorphism/neumorphic_theme.dart';
import '../../domain/entities/period_summary.dart';
import '../../domain/repositories/stats_repository.dart';
import '../bloc/stats_bloc.dart';
import '../bloc/stats_event.dart';
import '../bloc/stats_state.dart';

/// Bar chart showing completion % per period (day/week/month).
/// Uses fl_chart BarChart. Includes a day/week/month toggle above.
class CompletionBarChart extends StatelessWidget {
  const CompletionBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is! StatsDataLoaded) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _GroupByToggle(current: state.barGroupBy),
            const SizedBox(height: AppDimensions.md),
            _BarChartView(
              data: state.barChartData,
              groupBy: state.barGroupBy,
            ),
          ],
        );
      },
    );
  }
}

class _GroupByToggle extends StatelessWidget {
  const _GroupByToggle({required this.current});
  final BarChartGroupBy current;

  static const _options = [
    (BarChartGroupBy.daily, 'Day'),
    (BarChartGroupBy.monthly, 'Month'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
      child: Row(
        children: _options.map((opt) {
          final (groupBy, label) = opt;
          final isSelected = groupBy == current;
          return Padding(
            padding: const EdgeInsets.only(right: AppDimensions.sm),
            child: GestureDetector(
              onTap: () => context
                  .read<StatsBloc>()
                  .add(StatsBarGroupByChanged(groupBy)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.md,
                  vertical: AppDimensions.xs,
                ),
                decoration: isSelected
                    ? context.neumorphicInset.copyWith(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusRound,
                        ),
                      )
                    : context.neumorphicRaised.copyWith(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusRound,
                        ),
                      ),
                child: Text(
                  label,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _BarChartView extends StatelessWidget {
  const _BarChartView({required this.data, required this.groupBy});
  final List<PeriodSummary> data;
  final BarChartGroupBy groupBy;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(
        height: 440,
        child: Center(
          child:
              Text('No data for this range', style: AppTextStyles.bodyMedium),
        ),
      );
    }

    // For daily view show only the last 7 days.
    // Monthly view can still show more history for trend context.
    final visible = groupBy == BarChartGroupBy.daily
        ? (data.length > 7 ? data.sublist(data.length - 7) : data)
        : (data.length > 30 ? data.sublist(data.length - 30) : data);
    final barWidth = groupBy == BarChartGroupBy.monthly ? 20.0 : 12.0;

    final barGroups = visible.asMap().entries.map((e) {
      final pct = e.value.avgCompletionPct.clamp(0.0, 100.0);

      return BarChartGroupData(
        x: e.key,
        barRods: [
          BarChartRodData(
            toY: pct,
            width: barWidth,
            gradient: LinearGradient(
              colors: pct >= 50
                  ? [AppColors.primaryLight, AppColors.primary]
                  : [AppColors.warning, AppColors.danger],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            borderSide: pct < 50
                ? BorderSide(color: AppColors.danger.withValues(alpha: 0.6))
                : BorderSide.none,
          ),
        ],
      );
    }).toList();

    return SizedBox(
      height: 440,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
        child: BarChart(
          BarChartData(
            maxY: 100,
            minY: 0,
            barGroups: barGroups,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 25,
              getDrawingHorizontalLine: (value) => FlLine(
                color: AppColors.shadowDark.withValues(alpha: 0.3),
                strokeWidth: 1,
              ),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 25,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) => Text(
                    '${value.toInt()}%',
                    style: AppTextStyles.bodyMedium.copyWith(fontSize: 9),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 20,
                  getTitlesWidget: (value, meta) {
                    final idx = value.toInt();
                    if (idx < 0 || idx >= visible.length) {
                      return const SizedBox.shrink();
                    }
                    // For daily show every nth label to avoid crowding
                    final step = groupBy == BarChartGroupBy.daily
                        ? (visible.length / 6).ceil()
                        : 1;
                    if (idx % step != 0) return const SizedBox.shrink();
                    return Text(
                      visible[idx].label,
                      style: AppTextStyles.bodyMedium.copyWith(fontSize: 9),
                    );
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (_) =>
                    AppColors.surfaceElevated.withValues(alpha: 0.95),
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final period = visible[group.x];
                  return BarTooltipItem(
                    '${period.label}\n${rod.toY.toStringAsFixed(0)}%'
                    '\n${period.totalMinutes} min',
                    AppTextStyles.bodyMedium,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
