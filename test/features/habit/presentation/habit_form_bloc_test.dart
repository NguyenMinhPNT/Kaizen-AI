import 'package:flutter_test/flutter_test.dart';
import 'package:kaizen_ai/features/habit/domain/entities/habit_entity.dart';
import 'package:kaizen_ai/features/habit/domain/entities/habit_log_entity.dart';
import 'package:kaizen_ai/features/habit/domain/enums/habit_status.dart';
import 'package:kaizen_ai/features/habit/domain/repositories/habit_repository.dart';
import 'package:kaizen_ai/features/habit/domain/usecases/create_habit_usecase.dart';
import 'package:kaizen_ai/features/habit/domain/usecases/get_habit_by_id_usecase.dart';
import 'package:kaizen_ai/features/habit/domain/usecases/update_habit_usecase.dart';
import 'package:kaizen_ai/features/habit/presentation/bloc/habit_form_bloc.dart';
import 'package:kaizen_ai/features/habit/presentation/bloc/habit_form_event.dart';
import 'package:kaizen_ai/features/habit/presentation/bloc/habit_form_state.dart';

void main() {
  group('HabitFormBloc', () {
    late HabitFormBloc bloc;

    setUp(() {
      final repository = _FakeHabitRepository();
      bloc = HabitFormBloc(
        createHabit: CreateHabitUseCase(repository),
        getHabitById: GetHabitByIdUseCase(repository),
        updateHabit: UpdateHabitUseCase(repository),
      );
    });

    tearDown(() async {
      await bloc.close();
    });

    test('InitializeCreateForm moves bloc into ready state for create flow',
        () async {
      bloc.add(const InitializeCreateForm());
      await Future<void>.delayed(Duration.zero);

      expect(bloc.state, isA<HabitFormReady>());
      expect((bloc.state as HabitFormReady).isEdit, isFalse);
    });
  });
}

class _FakeHabitRepository implements HabitRepository {
  @override
  Future<void> archiveHabit(String id) async {}

  @override
  Future<void> createHabit(HabitEntity habit) async {}

  @override
  Future<void> deleteHabit(String id) async {}

  @override
  Future<List<HabitEntity>> getAllHabits() async => const [];

  @override
  Future<HabitEntity?> getHabitById(String id) async => null;

  @override
  Future<HabitLogEntity?> getLogForDate(String habitId, DateTime date) async =>
      null;

  @override
  Future<List<HabitLogEntity>> getLogsForHabit(String habitId) async =>
      const [];

  @override
  Future<HabitStatus?> getTodayStatus(String habitId) async => null;

  @override
  Future<void> levelDownHabit(String id) async {}

  @override
  Future<void> levelUpHabit(String id) async {}

  @override
  Future<void> logHabit(HabitLogEntity log) async {}

  @override
  Future<void> logTimerSession({
    required String habitId,
    required int targetMinutes,
    required int actualMinutes,
    required HabitStatus status,
    required double completionPct,
    required DateTime date,
  }) async {}

  @override
  Future<void> updateHabit(HabitEntity habit) async {}

  @override
  Stream<List<HabitEntity>> watchAllHabits() => const Stream.empty();
}
