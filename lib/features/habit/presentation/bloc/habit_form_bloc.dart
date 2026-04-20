import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/enums/level_up_mode.dart';
import '../../domain/enums/tree_type.dart';
import '../../domain/usecases/create_habit_usecase.dart';
import '../../domain/usecases/get_habit_by_id_usecase.dart';
import '../../domain/usecases/update_habit_usecase.dart';
import 'habit_form_event.dart';
import 'habit_form_state.dart';

// Internal event — lives here because it's private to this file.
class _HabitLoaded extends HabitFormEvent {
  final HabitEntity habit;
  const _HabitLoaded(this.habit);
  @override
  List<Object?> get props => [habit];
}

class HabitFormBloc extends Bloc<HabitFormEvent, HabitFormState> {
  final CreateHabitUseCase _createHabit;
  final GetHabitByIdUseCase _getHabitById;
  final UpdateHabitUseCase _updateHabit;

  HabitFormBloc({
    required CreateHabitUseCase createHabit,
    required GetHabitByIdUseCase getHabitById,
    required UpdateHabitUseCase updateHabit,
  })  : _createHabit = createHabit,
        _getHabitById = getHabitById,
        _updateHabit = updateHabit,
        super(const HabitFormInitial()) {
    on<InitializeCreateForm>(_onInitializeCreateForm);
    on<LoadForEdit>(_onLoadForEdit);
    on<_HabitLoaded>(_onHabitLoaded);
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<IconChanged>(_onIconChanged);
    on<ColorChanged>(_onColorChanged);
    on<DurationChanged>(_onDurationChanged);
    on<LevelUpModeChanged>(_onLevelUpModeChanged);
    on<TreeTypeChanged>(_onTreeTypeChanged);
    on<SubmitForm>(_onSubmit);
  }

  static HabitFormReady _defaultReady({bool isEdit = false, String? habitId}) =>
      HabitFormReady(
        name: '',
        description: '',
        iconCode: 0xe25a, // Icons.eco codepoint
        colorHex: AppConstants.defaultColorHex,
        currentDurationMinutes: AppConstants.defaultHabitDurationMinutes,
        maxDurationMinutes: AppConstants.defaultMaxDurationMinutes,
        incrementMinutes: AppConstants.defaultIncrementMinutes,
        levelUpMode: LevelUpMode.manual,
        treeType: TreeType.oak,
        isEdit: isEdit,
        habitId: habitId,
      );

  void _onInitializeCreateForm(
    InitializeCreateForm event,
    Emitter<HabitFormState> emit,
  ) {
    emit(_defaultReady());
  }

  Future<void> _onLoadForEdit(
    LoadForEdit event,
    Emitter<HabitFormState> emit,
  ) async {
    emit(const HabitFormLoading());
    final habit = await _getHabitById(event.habitId);
    if (habit == null) {
      emit(const HabitFormError('Habit not found'));
      return;
    }
    add(_HabitLoaded(habit));
  }

  void _onHabitLoaded(_HabitLoaded event, Emitter<HabitFormState> emit) {
    final h = event.habit;
    emit(HabitFormReady(
      name: h.name,
      description: h.description,
      iconCode: h.iconCode,
      colorHex: h.colorHex,
      currentDurationMinutes: h.currentDurationMinutes,
      maxDurationMinutes: h.maxDurationMinutes,
      incrementMinutes: h.incrementMinutes,
      levelUpMode: h.levelUpMode,
      treeType: h.treeType,
      isEdit: true,
      habitId: h.id,
    ));
  }

  void _onNameChanged(NameChanged event, Emitter<HabitFormState> emit) {
    final s = state;
    if (s is! HabitFormReady) {
      emit(_defaultReady().copyWith(name: event.name));
      return;
    }
    emit(s.copyWith(name: event.name, nameError: false));
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<HabitFormState> emit,
  ) {
    final s = state;
    if (s is! HabitFormReady) return;
    emit(s.copyWith(description: event.description));
  }

  void _onIconChanged(IconChanged event, Emitter<HabitFormState> emit) {
    final s = state;
    if (s is! HabitFormReady) return;
    emit(s.copyWith(iconCode: event.iconCode));
  }

  void _onColorChanged(ColorChanged event, Emitter<HabitFormState> emit) {
    final s = state;
    if (s is! HabitFormReady) return;
    emit(s.copyWith(colorHex: event.colorHex));
  }

  void _onDurationChanged(DurationChanged event, Emitter<HabitFormState> emit) {
    final s = state;
    if (s is! HabitFormReady) return;
    emit(s.copyWith(
      currentDurationMinutes: event.currentDurationMinutes,
      maxDurationMinutes: event.maxDurationMinutes,
      incrementMinutes: event.incrementMinutes,
    ));
  }

  void _onLevelUpModeChanged(
    LevelUpModeChanged event,
    Emitter<HabitFormState> emit,
  ) {
    final s = state;
    if (s is! HabitFormReady) return;
    emit(s.copyWith(levelUpMode: event.mode));
  }

  void _onTreeTypeChanged(TreeTypeChanged event, Emitter<HabitFormState> emit) {
    final s = state;
    if (s is! HabitFormReady) return;
    emit(s.copyWith(treeType: event.treeType));
  }

  Future<void> _onSubmit(
    SubmitForm event,
    Emitter<HabitFormState> emit,
  ) async {
    final s = state;
    if (s is! HabitFormReady) return;

    if (s.name.trim().isEmpty) {
      emit(s.copyWith(nameError: true));
      return;
    }

    emit(const HabitFormSubmitting());

    try {
      final now = DateTime.now();
      final entity = HabitEntity(
        id: s.habitId ?? '',
        name: s.name.trim(),
        description: s.description.trim(),
        iconCode: s.iconCode,
        colorHex: s.colorHex,
        currentDurationMinutes: s.currentDurationMinutes,
        maxDurationMinutes: s.maxDurationMinutes,
        incrementMinutes: s.incrementMinutes,
        treeType: s.treeType,
        levelUpMode: s.levelUpMode,
        currentStreak: 0,
        longestStreak: 0,
        totalCompletedDays: 0,
        isArchived: false,
        createdAt: now,
        updatedAt: now,
      );

      if (s.isEdit) {
        await _updateHabit(entity);
      } else {
        await _createHabit(entity);
      }
      emit(const HabitFormSuccess());
    } catch (e) {
      emit(HabitFormError(e.toString()));
    }
  }
}
