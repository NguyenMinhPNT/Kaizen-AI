import 'package:equatable/equatable.dart';

abstract class HabitListEvent extends Equatable {
  const HabitListEvent();
  @override
  List<Object?> get props => [];
}

class LoadHabits extends HabitListEvent {
  const LoadHabits();
}

class DeleteHabitEvent extends HabitListEvent {
  final String habitId;
  const DeleteHabitEvent(this.habitId);
  @override
  List<Object?> get props => [habitId];
}

class ArchiveHabitEvent extends HabitListEvent {
  final String habitId;
  const ArchiveHabitEvent(this.habitId);
  @override
  List<Object?> get props => [habitId];
}

class LevelUpHabitEvent extends HabitListEvent {
  final String habitId;
  const LevelUpHabitEvent(this.habitId);
  @override
  List<Object?> get props => [habitId];
}

class LevelDownHabitEvent extends HabitListEvent {
  final String habitId;
  const LevelDownHabitEvent(this.habitId);
  @override
  List<Object?> get props => [habitId];
}
