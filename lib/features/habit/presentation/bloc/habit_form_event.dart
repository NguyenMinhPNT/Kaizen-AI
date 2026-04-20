import 'package:equatable/equatable.dart';
import '../../domain/enums/level_up_mode.dart';
import '../../domain/enums/tree_type.dart';

abstract class HabitFormEvent extends Equatable {
  const HabitFormEvent();
  @override
  List<Object?> get props => [];
}

class InitializeCreateForm extends HabitFormEvent {
  const InitializeCreateForm();
}

class LoadForEdit extends HabitFormEvent {
  final String habitId;
  const LoadForEdit(this.habitId);
  @override
  List<Object?> get props => [habitId];
}

class NameChanged extends HabitFormEvent {
  final String name;
  const NameChanged(this.name);
  @override
  List<Object?> get props => [name];
}

class DescriptionChanged extends HabitFormEvent {
  final String description;
  const DescriptionChanged(this.description);
  @override
  List<Object?> get props => [description];
}

class IconChanged extends HabitFormEvent {
  final int iconCode;
  const IconChanged(this.iconCode);
  @override
  List<Object?> get props => [iconCode];
}

class ColorChanged extends HabitFormEvent {
  final String colorHex;
  const ColorChanged(this.colorHex);
  @override
  List<Object?> get props => [colorHex];
}

class DurationChanged extends HabitFormEvent {
  final int currentDurationMinutes;
  final int maxDurationMinutes;
  final int incrementMinutes;
  const DurationChanged({
    required this.currentDurationMinutes,
    required this.maxDurationMinutes,
    required this.incrementMinutes,
  });
  @override
  List<Object?> get props => [
        currentDurationMinutes,
        maxDurationMinutes,
        incrementMinutes,
      ];
}

class LevelUpModeChanged extends HabitFormEvent {
  final LevelUpMode mode;
  const LevelUpModeChanged(this.mode);
  @override
  List<Object?> get props => [mode];
}

class TreeTypeChanged extends HabitFormEvent {
  final TreeType treeType;
  const TreeTypeChanged(this.treeType);
  @override
  List<Object?> get props => [treeType];
}

class SubmitForm extends HabitFormEvent {
  const SubmitForm();
}
