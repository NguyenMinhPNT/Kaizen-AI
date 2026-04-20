// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:kaizen_ai/app/di/injection_container.dart' as _i870;
import 'package:kaizen_ai/core/database/app_database.dart' as _i422;
import 'package:kaizen_ai/core/database/daos/habit_dao.dart' as _i213;
import 'package:kaizen_ai/core/database/daos/habit_log_dao.dart' as _i300;
import 'package:kaizen_ai/core/database/daos/habit_tree_dao.dart' as _i590;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final databaseModule = _$DatabaseModule();
    gh.singleton<_i422.AppDatabase>(() => databaseModule.database);
    gh.singleton<_i213.HabitDao>(
        () => databaseModule.habitDao(gh<_i422.AppDatabase>()));
    gh.singleton<_i300.HabitLogDao>(
        () => databaseModule.habitLogDao(gh<_i422.AppDatabase>()));
    gh.singleton<_i590.HabitTreeDao>(
        () => databaseModule.habitTreeDao(gh<_i422.AppDatabase>()));
    return this;
  }
}

class _$DatabaseModule extends _i870.DatabaseModule {}
