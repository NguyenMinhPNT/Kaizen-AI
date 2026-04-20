import 'package:equatable/equatable.dart';
import '../../domain/enums/level_up_mode.dart';
import '../../domain/enums/tree_type.dart';

abstract class HabitFormState extends Equatable {
  const HabitFormState();
  @override
  List<Object?> get props => [];
}

class HabitFormInitial extends HabitFormState {
  const HabitFormInitial();
}

class HabitFormLoading extends HabitFormState {
  const HabitFormLoading();
}

class HabitFormReady extends HabitFormState {
  final String name;
  final String description;
  final int iconCode;
  final String colorHex;
  final int currentDurationMinutes;
  final int maxDurationMinutes;
  final int incrementMinutes;
  final LevelUpMode levelUpMode;
  final TreeType treeType;
  final bool isEdit;
  final String? habitId;
  final bool nameError;

  const HabitFormReady({
    required this.name,
    required this.description,
    required this.iconCode,
    required this.colorHex,
    required this.currentDurationMinutes,
    required this.maxDurationMinutes,
    required this.incrementMinutes,
    required this.levelUpMode,
    required this.treeType,
    required this.isEdit,
    this.habitId,
    this.nameError = false,
  });

  HabitFormReady copyWith({
    String? name,
    String? description,
    int? iconCode,
    String? colorHex,
    int? currentDurationMinutes,
    int? maxDurationMinutes,
    int? incrementMinutes,
    LevelUpMode? levelUpMode,
    TreeType? treeType,
    bool? nameError,
  }) {
    return HabitFormReady(
      name: name ?? this.name,
      description: description ?? this.description,
      iconCode: iconCode ?? this.iconCode,
      colorHex: colorHex ?? this.colorHex,
      currentDurationMinutes:
          currentDurationMinutes ?? this.currentDurationMinutes,
      maxDurationMinutes: maxDurationMinutes ?? this.maxDurationMinutes,
      incrementMinutes: incrementMinutes ?? this.incrementMinutes,
      levelUpMode: levelUpMode ?? this.levelUpMode,
      treeType: treeType ?? this.treeType,
      isEdit: isEdit,
      habitId: habitId,
      nameError: nameError ?? this.nameError,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        iconCode,
        colorHex,
        currentDurationMinutes,
        maxDurationMinutes,
        incrementMinutes,
        levelUpMode,
        treeType,
        isEdit,
        habitId,
        nameError,
      ];
}

class HabitFormSubmitting extends HabitFormState {
  const HabitFormSubmitting();
}

class HabitFormSuccess extends HabitFormState {
  const HabitFormSuccess();
}

class HabitFormError extends HabitFormState {
  final String message;
  const HabitFormError(this.message);
  @override
  List<Object?> get props => [message];
}
