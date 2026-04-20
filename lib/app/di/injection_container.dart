import 'package:drift_flutter/drift_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../../core/database/app_database.dart';
import '../../core/database/daos/habit_dao.dart';
import '../../core/database/daos/habit_log_dao.dart';
import '../../core/database/daos/habit_tree_dao.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

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
