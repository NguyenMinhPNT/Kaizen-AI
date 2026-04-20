import 'package:equatable/equatable.dart';
import '../../domain/entities/habit_entity.dart';

abstract class HabitListState extends Equatable {
  const HabitListState();
  @override
  List<Object?> get props => [];
}

class HabitListInitial extends HabitListState {
  const HabitListInitial();
}

class HabitListLoading extends HabitListState {
  const HabitListLoading();
}

class HabitListLoaded extends HabitListState {
  final List<HabitEntity> habits;
  const HabitListLoaded(this.habits);
  @override
  List<Object?> get props => [habits];
}

class HabitListError extends HabitListState {
  final String message;
  const HabitListError(this.message);
  @override
  List<Object?> get props => [message];
}
