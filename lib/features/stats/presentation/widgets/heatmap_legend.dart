import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Color swatch row explaining the heatmap dot colors.
class HeatmapLegend extends StatelessWidget {
  const HeatmapLegend({super.key});

  static const _items = [
    (_LegendItem(color: AppColors.missed, label: 'None/Skip')),
    (_LegendItem(color: AppColors.warning, label: 'Gave up')),
    (_LegendItem(color: AppColors.heatLevel1, label: '≤20 m')),
    (_LegendItem(color: AppColors.heatLevel2, label: '≤30 m')),
    (_LegendItem(color: AppColors.heatLevel3, label: '≤45 m')),
    (_LegendItem(color: AppColors.heatLevel4, label: '≤60 m')),
    (_LegendItem(color: AppColors.heatLevel5, label: '≤90 m')),
    (_LegendItem(color: AppColors.heatLevel6, label: '90+ m')),
  ];

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.md),
      child: Wrap(
        spacing: AppDimensions.md,
        runSpacing: AppDimensions.xs,
        children: _items,
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppDimensions.heatmapCellSize,
          height: AppDimensions.heatmapCellSize,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppDimensions.xs),
        Text(label, style: AppTextStyles.bodyMedium),
      ],
    );
  }
}
