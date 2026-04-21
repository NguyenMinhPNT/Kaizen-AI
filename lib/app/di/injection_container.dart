import 'package:drift_flutter/drift_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/database/app_database.dart';
import '../../core/database/daos/habit_dao.dart';
import '../../core/database/daos/habit_log_dao.dart';
import '../../core/database/daos/habit_tree_dao.dart';
import '../../features/habit/data/datasources/habit_local_datasource.dart';
import '../../features/habit/data/repositories/habit_repository_impl.dart';
import '../../features/habit/domain/repositories/habit_repository.dart';
import '../../features/habit/domain/usecases/archive_habit_usecase.dart';
import '../../features/habit/domain/usecases/create_habit_usecase.dart';
import '../../features/habit/domain/usecases/delete_habit_usecase.dart';
import '../../features/habit/domain/usecases/get_all_habits_usecase.dart';
import '../../features/habit/domain/usecases/get_habit_by_id_usecase.dart';
import '../../features/habit/domain/usecases/level_down_habit_usecase.dart';
import '../../features/habit/domain/usecases/level_up_habit_usecase.dart';
import '../../features/habit/domain/usecases/update_habit_usecase.dart';
import '../../features/habit/presentation/bloc/habit_form_bloc.dart';
import '../../features/habit/presentation/bloc/habit_list_bloc.dart';
import '../../features/timer/data/datasources/timer_service.dart';
import '../../features/timer/data/repositories/timer_repository_impl.dart';
import '../../features/timer/domain/repositories/timer_repository.dart';
import '../../features/timer/domain/usecases/finish_timer_usecase.dart';
import '../../features/timer/domain/usecases/give_up_timer_usecase.dart';
import '../../features/timer/domain/usecases/pause_timer_usecase.dart';
import '../../features/timer/domain/usecases/resume_timer_usecase.dart';
import '../../features/timer/domain/usecases/start_timer_usecase.dart';
import '../../features/timer/presentation/bloc/timer_bloc.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
  _registerHabitDependencies();
  await _registerTimerDependencies();
}

/// Module that registers database-related singletons.
@module
abstract class DatabaseModule {
  @singleton
  AppDatabase get database => AppDatabase(
        driftDatabase(name: 'kaizen_db'),
      );

  @singleton
  HabitDao habitDao(AppDatabase db) => db.habitDao;

  @singleton
  HabitLogDao habitLogDao(AppDatabase db) => db.habitLogDao;

  @singleton
  HabitTreeDao habitTreeDao(AppDatabase db) => db.habitTreeDao;
}

/// Registers Sprint 2 habit feature dependencies manually
/// (no build_runner re-run needed for new classes).
void _registerHabitDependencies() {
  // ── Data layer
  getIt.registerLazySingleton<HabitLocalDatasource>(
    () => HabitLocalDatasource(
      getIt<HabitDao>(),
      getIt<HabitLogDao>(),
      getIt<AppDatabase>(),
    ),
  );

  getIt.registerLazySingleton<HabitRepository>(
    () => HabitRepositoryImpl(getIt<HabitLocalDatasource>()),
  );

  // ── Use cases
  getIt.registerLazySingleton(
      () => CreateHabitUseCase(getIt<HabitRepository>()));
  getIt.registerLazySingleton(
      () => GetAllHabitsUseCase(getIt<HabitRepository>()));
  getIt.registerLazySingleton(
      () => GetHabitByIdUseCase(getIt<HabitRepository>()));
  getIt.registerLazySingleton(
      () => UpdateHabitUseCase(getIt<HabitRepository>()));
  getIt.registerLazySingleton(
      () => DeleteHabitUseCase(getIt<HabitRepository>()));
  getIt.registerLazySingleton(
      () => ArchiveHabitUseCase(getIt<HabitRepository>()));
  getIt.registerLazySingleton(
      () => LevelUpHabitUseCase(getIt<HabitRepository>()));
  getIt.registerLazySingleton(
      () => LevelDownHabitUseCase(getIt<HabitRepository>()));

  // ── BLoCs (factory — new instance per screen)
  getIt.registerFactory<HabitListBloc>(
    () => HabitListBloc(
      getAllHabits: getIt<GetAllHabitsUseCase>(),
      deleteHabit: getIt<DeleteHabitUseCase>(),
      archiveHabit: getIt<ArchiveHabitUseCase>(),
      levelUpHabit: getIt<LevelUpHabitUseCase>(),
      levelDownHabit: getIt<LevelDownHabitUseCase>(),
    ),
  );
  getIt.registerFactory<HabitFormBloc>(
    () => HabitFormBloc(
      createHabit: getIt<CreateHabitUseCase>(),
      getHabitById: getIt<GetHabitByIdUseCase>(),
      updateHabit: getIt<UpdateHabitUseCase>(),
    ),
  );
}

/// Registers Sprint 3 timer feature dependencies.
Future<void> _registerTimerDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  // ── Data layer
  getIt.registerLazySingleton<TimerService>(() => TimerService(prefs));

  getIt.registerLazySingleton<TimerRepository>(
    () => TimerRepositoryImpl(getIt<TimerService>()),
  );

  // ── Use cases
  getIt.registerLazySingleton(
    () => StartTimerUseCase(getIt<TimerRepository>()),
  );
  getIt.registerLazySingleton(
    () => PauseTimerUseCase(getIt<TimerRepository>()),
  );
  getIt.registerLazySingleton(
    () => ResumeTimerUseCase(getIt<TimerRepository>()),
  );
  getIt.registerLazySingleton(
    () => GiveUpTimerUseCase(
      timerRepo: getIt<TimerRepository>(),
      habitRepo: getIt<HabitRepository>(),
    ),
  );
  getIt.registerLazySingleton(
    () => FinishTimerUseCase(
      timerRepo: getIt<TimerRepository>(),
      habitRepo: getIt<HabitRepository>(),
    ),
  );

  // ── BLoC (factory — new instance per screen)
  getIt.registerFactory<TimerBloc>(
    () => TimerBloc(
      start: getIt<StartTimerUseCase>(),
      pause: getIt<PauseTimerUseCase>(),
      resume: getIt<ResumeTimerUseCase>(),
      giveUp: getIt<GiveUpTimerUseCase>(),
      finish: getIt<FinishTimerUseCase>(),
      timerRepo: getIt<TimerRepository>(),
    ),
  );
}
