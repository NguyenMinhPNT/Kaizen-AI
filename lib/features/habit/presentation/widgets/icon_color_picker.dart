import 'package:flutter/material.dart';
import '../../../../core/extensions/color_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/neumorphism/neumorphic_theme.dart';

const List<String> _kDefaultColors = [
  '#4CAF50', // green
  '#2196F3', // blue
  '#9C27B0', // purple
  '#F44336', // red
  '#FF9800', // orange
  '#FBC02D', // yellow
  '#00BCD4', // cyan
  '#E91E63', // pink
  '#795548', // brown
  '#607D8B', // blue-grey
];

const List<IconData> _kDefaultIcons = [
  Icons.eco,
  Icons.fitness_center,
  Icons.menu_book,
  Icons.self_improvement,
  Icons.directions_run,
  Icons.local_drink,
  Icons.nightlight,
  Icons.music_note,
  Icons.code,
  Icons.brush,
  Icons.camera_alt,
  Icons.favorite,
  Icons.psychology,
  Icons.school,
  Icons.kitchen,
  Icons.pedal_bike,
  Icons.pool,
  Icons.sports_basketball,
  Icons.volunteer_activism,
  Icons.language,
];

class IconColorPicker extends StatefulWidget {
  const IconColorPicker({
    super.key,
    required this.selectedIconCode,
    required this.selectedColorHex,
    required this.onIconChanged,
    required this.onColorChanged,
  });

  final int selectedIconCode;
  final String selectedColorHex;
  final ValueChanged<int> onIconChanged;
  final ValueChanged<String> onColorChanged;

  @override
  State<IconColorPicker> createState() => _IconColorPickerState();
}

class _IconColorPickerState extends State<IconColorPicker>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textHint,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Icon'),
            Tab(text: 'Color'),
          ],
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _tabController,
            children: [
              _IconGrid(
                selectedIconCode: widget.selectedIconCode,
                onIconChanged: widget.onIconChanged,
              ),
              _ColorGrid(
                selectedColorHex: widget.selectedColorHex,
                onColorChanged: widget.onColorChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconGrid extends StatelessWidget {
  const _IconGrid({
    required this.selectedIconCode,
    required this.onIconChanged,
  });
  final int selectedIconCode;
  final ValueChanged<int> onIconChanged;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppDimensions.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: AppDimensions.sm,
        crossAxisSpacing: AppDimensions.sm,
      ),
      itemCount: _kDefaultIcons.length,
      itemBuilder: (_, i) {
        final icon = _kDefaultIcons[i];
        final isSelected = icon.codePoint == selectedIconCode;
        return GestureDetector(
          onTap: () => onIconChanged(icon.codePoint),
          child: Container(
            decoration: isSelected
                ? context.neumorphicInset.copyWith(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  )
                : context.neumorphicRaised.copyWith(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  ),
            child: Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: AppDimensions.iconMd,
            ),
          ),
        );
      },
    );
  }
}

class _ColorGrid extends StatelessWidget {
  const _ColorGrid({
    required this.selectedColorHex,
    required this.onColorChanged,
  });
  final String selectedColorHex;
  final ValueChanged<String> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppDimensions.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: AppDimensions.sm,
        crossAxisSpacing: AppDimensions.sm,
      ),
      itemCount: _kDefaultColors.length,
      itemBuilder: (_, i) {
        final hex = _kDefaultColors[i];
        final color = ColorExtensions.fromHex(hex);
        final isSelected = hex.toLowerCase() == selectedColorHex.toLowerCase();
        return GestureDetector(
          onTap: () => onColorChanged(hex),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: isSelected
                  ? Border.all(color: AppColors.textPrimary, width: 3)
                  : null,
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : null,
          ),
        );
      },
    );
  }
}

/// Preview widget shown in the form header.
class HabitIconPreview extends StatelessWidget {
  const HabitIconPreview({
    super.key,
    required this.iconCode,
    required this.colorHex,
    this.size = 64,
  });

  final int iconCode;
  final String colorHex;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = ColorExtensions.fromHex(colorHex);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
      ),
      child: Center(
        child: Icon(
          IconData(iconCode, fontFamily: 'MaterialIcons'),
          color: color,
          size: size * 0.45,
        ),
      ),
    );
  }
}

/// Small label shown below the preview.
class HabitIconLabel extends StatelessWidget {
  const HabitIconLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.isEmpty ? 'Tap to set name' : label,
      style: label.isEmpty
          ? AppTextStyles.bodyMedium
          : AppTextStyles.headlineMedium,
      textAlign: TextAlign.center,
    );
  }
}
