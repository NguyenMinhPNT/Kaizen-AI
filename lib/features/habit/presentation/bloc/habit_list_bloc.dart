import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/usecases/get_all_habits_usecase.dart';
import '../../domain/usecases/delete_habit_usecase.dart';
import '../../domain/usecases/archive_habit_usecase.dart';
import '../../domain/usecases/level_up_habit_usecase.dart';
import '../../domain/usecases/level_down_habit_usecase.dart';
import 'habit_list_event.dart';
import 'habit_list_state.dart';

// Internal event — lives here because it's private to this file.
class _HabitsUpdated extends HabitListEvent {
  final List<HabitEntity> habits;
  const _HabitsUpdated(this.habits);
  @override
  List<Object?> get props => [habits];
}

class HabitListBloc extends Bloc<HabitListEvent, HabitListState> {
  final GetAllHabitsUseCase _getAllHabits;
  final DeleteHabitUseCase _deleteHabit;
  final ArchiveHabitUseCase _archiveHabit;
  final LevelUpHabitUseCase _levelUpHabit;
  final LevelDownHabitUseCase _levelDownHabit;

  StreamSubscription? _habitsSubscription;

  HabitListBloc({
    required GetAllHabitsUseCase getAllHabits,
    required DeleteHabitUseCase deleteHabit,
    required ArchiveHabitUseCase archiveHabit,
    required LevelUpHabitUseCase levelUpHabit,
    required LevelDownHabitUseCase levelDownHabit,
  })  : _getAllHabits = getAllHabits,
        _deleteHabit = deleteHabit,
        _archiveHabit = archiveHabit,
        _levelUpHabit = levelUpHabit,
        _levelDownHabit = levelDownHabit,
        super(const HabitListInitial()) {
    on<LoadHabits>(_onLoad);
    on<_HabitsUpdated>(_onUpdated);
    on<DeleteHabitEvent>(_onDelete);
    on<ArchiveHabitEvent>(_onArchive);
    on<LevelUpHabitEvent>(_onLevelUp);
    on<LevelDownHabitEvent>(_onLevelDown);
  }

  void _onLoad(LoadHabits event, Emitter<HabitListState> emit) {
    emit(const HabitListLoading());
    _habitsSubscription?.cancel();
    _habitsSubscription = _getAllHabits.watch().listen(
          (habits) => add(_HabitsUpdated(habits)),
          onError: (e) => emit(HabitListError(e.toString())),
        );
  }

  void _onUpdated(_HabitsUpdated event, Emitter<HabitListState> emit) {
    emit(HabitListLoaded(event.habits));
  }

  Future<void> _onDelete(
    DeleteHabitEvent event,
    Emitter<HabitListState> emit,
  ) async {
    try {
      await _deleteHabit(event.habitId);
    } catch (e) {
      emit(HabitListError(e.toString()));
    }
  }

  Future<void> _onArchive(
    ArchiveHabitEvent event,
    Emitter<HabitListState> emit,
  ) async {
    try {
      await _archiveHabit(event.habitId);
    } catch (e) {
      emit(HabitListError(e.toString()));
    }
  }

  Future<void> _onLevelUp(
    LevelUpHabitEvent event,
    Emitter<HabitListState> emit,
  ) async {
    try {
      await _levelUpHabit(event.habitId);
    } catch (e) {
      emit(HabitListError(e.toString()));
    }
  }

  Future<void> _onLevelDown(
    LevelDownHabitEvent event,
    Emitter<HabitListState> emit,
  ) async {
    try {
      await _levelDownHabit(event.habitId);
    } catch (e) {
      emit(HabitListError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _habitsSubscription?.cancel();
    return super.close();
  }
}
