import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/neumorphism/neumorphic_theme.dart';
import '../../../../core/widgets/neumorphic_button.dart';
import '../../domain/enums/level_up_mode.dart';
import '../../domain/enums/tree_type.dart';
import '../bloc/habit_form_bloc.dart';
import '../bloc/habit_form_event.dart';
import '../bloc/habit_form_state.dart';
import 'icon_color_picker.dart';

class HabitFormBody extends StatelessWidget {
  const HabitFormBody({super.key, required this.isEdit, this.habitId});

  final bool isEdit;
  final String? habitId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HabitFormBloc, HabitFormState>(
      listenWhen: (_, current) =>
          current is HabitFormSuccess || current is HabitFormError,
      listener: (context, state) {
        if (state is HabitFormSuccess) {
          Navigator.of(context).pop();
        } else if (state is HabitFormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is HabitFormLoading) {
          return Scaffold(
            appBar: _buildAppBar(context, isEdit),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HabitFormReady) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: _buildAppBar(context, isEdit),
            body: _FormContent(state: state),
            bottomNavigationBar: _SaveButton(
              isSubmitting: false,
              onPressed: () =>
                  context.read<HabitFormBloc>().add(const SubmitForm()),
            ),
          );
        }

        if (state is HabitFormSubmitting) {
          return Scaffold(
            appBar: _buildAppBar(context, isEdit),
            body: const Center(child: CircularProgressIndicator()),
            bottomNavigationBar: const _SaveButton(
              isSubmitting: true,
              onPressed: null,
            ),
          );
        }

        // Initial / unexpected state — render empty scaffold
        return Scaffold(
          appBar: _buildAppBar(context, isEdit),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isEdit) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        isEdit ? 'Edit Habit' : 'New Habit',
        style: AppTextStyles.headlineMedium,
      ),
      centerTitle: true,
    );
  }
}

// ── Form content ────────────────────────────────────────────────────────────

class _FormContent extends StatefulWidget {
  const _FormContent({required this.state});
  final HabitFormReady state;

  @override
  State<_FormContent> createState() => _FormContentState();
}

class _FormContentState extends State<_FormContent> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.state.name);
    _descCtrl = TextEditingController(text: widget.state.description);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.state;
    final bloc = context.read<HabitFormBloc>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Icon/Color preview header
          _PreviewHeader(
              iconCode: s.iconCode, colorHex: s.colorHex, name: s.name),
          const SizedBox(height: AppDimensions.lg),

          // ── Icon/Color picker
          _SectionCard(
            child: IconColorPicker(
              selectedIconCode: s.iconCode,
              selectedColorHex: s.colorHex,
              onIconChanged: (code) => bloc.add(IconChanged(code)),
              onColorChanged: (hex) => bloc.add(ColorChanged(hex)),
            ),
          ),
          const SizedBox(height: AppDimensions.md),

          // ── Name field
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FieldLabel('Habit Name'),
                const SizedBox(height: AppDimensions.xs),
                TextField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    hintText: 'e.g. Morning Run',
                    border: InputBorder.none,
                    errorText: s.nameError ? 'Name is required' : null,
                    isDense: true,
                  ),
                  style: AppTextStyles.bodyLarge,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (v) => bloc.add(NameChanged(v)),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.md),

          // ── Description field
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FieldLabel('Description (optional)'),
                const SizedBox(height: AppDimensions.xs),
                TextField(
                  controller: _descCtrl,
                  decoration: const InputDecoration(
                    hintText: 'What is this habit about?',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style: AppTextStyles.bodyLarge,
                  maxLines: 3,
                  onChanged: (v) => bloc.add(DescriptionChanged(v)),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.md),

          // ── Duration settings
          _SectionCard(
            child: _DurationSection(
              state: s,
              enabled: s.levelUpMode != LevelUpMode.autopilot,
            ),
          ),
          const SizedBox(height: AppDimensions.md),

          // ── Level up mode
          _SectionCard(
            child: _LevelUpModeSection(selected: s.levelUpMode),
          ),
          const SizedBox(height: AppDimensions.md),

          // ── Tree type
          _SectionCard(
            child: _TreeTypeSection(selected: s.treeType),
          ),
          const SizedBox(height: AppDimensions.xxl),
        ],
      ),
    );
  }
}

// ── Reusable section card ────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.md),
      decoration: context.neumorphicRaised.copyWith(
        color: context.neumorphicSurfaceElevated,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: child,
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textHint,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    );
  }
}

// ── Preview header ───────────────────────────────────────────────────────────

class _PreviewHeader extends StatelessWidget {
  const _PreviewHeader({
    required this.iconCode,
    required this.colorHex,
    required this.name,
  });
  final int iconCode;
  final String colorHex;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HabitIconPreview(iconCode: iconCode, colorHex: colorHex, size: 72),
        const SizedBox(height: AppDimensions.sm),
        HabitIconLabel(label: name),
      ],
    );
  }
}

// ── Duration section ─────────────────────────────────────────────────────────

class _DurationSection extends StatelessWidget {
  const _DurationSection({required this.state, required this.enabled});
  final HabitFormReady state;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HabitFormBloc>();

    void emit({int? current, int? max, int? increment}) {
      bloc.add(DurationChanged(
        currentDurationMinutes: current ?? state.currentDurationMinutes,
        maxDurationMinutes: max ?? state.maxDurationMinutes,
        incrementMinutes: increment ?? state.incrementMinutes,
      ));
    }

    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: AbsorbPointer(
        absorbing: !enabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _FieldLabel('Duration Settings'),
            const SizedBox(height: AppDimensions.md),
            _StepperRow(
              label: 'Current',
              value: state.currentDurationMinutes,
              unit: 'min',
              min: 5,
              max: state.maxDurationMinutes,
              step: state.incrementMinutes,
              onDecrement: () => emit(
                current: (state.currentDurationMinutes - state.incrementMinutes)
                    .clamp(5, state.maxDurationMinutes),
              ),
              onIncrement: () => emit(
                current: (state.currentDurationMinutes + state.incrementMinutes)
                    .clamp(5, state.maxDurationMinutes),
              ),
            ),
            const SizedBox(height: AppDimensions.sm),
            _StepperRow(
              label: 'Increment',
              value: state.incrementMinutes,
              unit: 'min',
              min: 1,
              max: 30,
              step: 1,
              onDecrement: () =>
                  emit(increment: (state.incrementMinutes - 1).clamp(1, 30)),
              onIncrement: () =>
                  emit(increment: (state.incrementMinutes + 1).clamp(1, 30)),
            ),
            const SizedBox(height: AppDimensions.sm),
            _StepperRow(
              label: 'Max',
              value: state.maxDurationMinutes,
              unit: 'min',
              min: state.currentDurationMinutes,
              max: 480,
              step: 5,
              onDecrement: () => emit(
                max: (state.maxDurationMinutes - 5)
                    .clamp(state.currentDurationMinutes, 480),
              ),
              onIncrement: () => emit(
                max: (state.maxDurationMinutes + 5)
                    .clamp(state.currentDurationMinutes, 480),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepperRow extends StatelessWidget {
  const _StepperRow({
    required this.label,
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.step,
    required this.onDecrement,
    required this.onIncrement,
  });

  final String label;
  final int value;
  final String unit;
  final int min;
  final int max;
  final int step;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: AppTextStyles.bodyMedium),
        ),
        _StepButton(
          icon: Icons.remove,
          onPressed: value > min ? onDecrement : null,
        ),
        SizedBox(
          width: 80,
          child: Text(
            '$value $unit',
            style: AppTextStyles.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        _StepButton(
          icon: Icons.add,
          onPressed: value < max ? onIncrement : null,
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, this.onPressed});
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      width: 36,
      height: 36,
      borderRadius: AppDimensions.radiusSm,
      surfaceColor: context.neumorphicSurfaceElevated,
      child: Icon(
        icon,
        size: 18,
        color: onPressed != null ? AppColors.textPrimary : AppColors.textHint,
      ),
    );
  }
}

// ── Level up mode section ────────────────────────────────────────────────────

class _LevelUpModeSection extends StatelessWidget {
  const _LevelUpModeSection({required this.selected});
  final LevelUpMode selected;

  static const _modes = [
    (
      LevelUpMode.manual,
      'Manual',
      Icons.touch_app_outlined,
      'You decide when to level up/down'
    ),
    (
      LevelUpMode.copilot,
      'Copilot',
      Icons.assistant_outlined,
      'AI suggests when ready'
    ),
    (
      LevelUpMode.autopilot,
      'Autopilot',
      Icons.auto_awesome_outlined,
      'AI levels up/down automatically'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HabitFormBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel('Level Up/Down Mode'),
        const SizedBox(height: AppDimensions.sm),
        ..._modes.map((entry) {
          final (mode, label, icon, subtitle) = entry;
          final isSelected = selected == mode;
          return GestureDetector(
            onTap: () => bloc.add(LevelUpModeChanged(mode)),
            child: Container(
              margin: const EdgeInsets.only(bottom: AppDimensions.xs),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.md,
                vertical: AppDimensions.sm,
              ),
              decoration: isSelected
                  ? context.neumorphicInset.copyWith(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusSm),
                    )
                  : context.neumorphicRaised.copyWith(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusSm),
                    ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: AppDimensions.iconMd,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppDimensions.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textHint,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle,
                        color: AppColors.primary, size: 20),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ── Tree type section ────────────────────────────────────────────────────────

class _TreeTypeSection extends StatelessWidget {
  const _TreeTypeSection({required this.selected});
  final TreeType selected;

  static const _trees = [
    (TreeType.oak, 'Oak', '🌳'),
    (TreeType.pine, 'Pine', '🌲'),
    (TreeType.cherry, 'Cherry', '🌸'),
    (TreeType.bamboo, 'Bamboo', '🎋'),
    (TreeType.bonsai, 'Bonsai', '🪴'),
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HabitFormBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel('Tree Type'),
        const SizedBox(height: AppDimensions.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _trees.map((entry) {
            final (type, label, emoji) = entry;
            final isSelected = selected == type;
            return GestureDetector(
              onTap: () => bloc.add(TreeTypeChanged(type)),
              child: Container(
                width: 56,
                height: 72,
                decoration: isSelected
                    ? context.neumorphicInset.copyWith(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusSm),
                      )
                    : context.neumorphicRaised.copyWith(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusSm),
                      ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 24)),
                    const SizedBox(height: AppDimensions.xs),
                    Text(
                      label,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 11,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ── Save button ──────────────────────────────────────────────────────────────

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.isSubmitting, required this.onPressed});
  final bool isSubmitting;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.md),
        child: SizedBox(
          height: 52,
          child: NeumorphicButton(
            onPressed: onPressed,
            borderRadius: AppDimensions.radiusMd,
            surfaceColor: AppColors.primary,
            child: isSubmitting
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.onPrimary,
                    ),
                  )
                : Text(
                    'Save Habit',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
