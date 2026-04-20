import 'package:drift/drift.dart';
import 'tables.dart';
import 'daos/habit_dao.dart';
import 'daos/habit_log_dao.dart';
import 'daos/habit_tree_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Habits, HabitLogs, HabitTrees],
  daos: [HabitDao, HabitLogDao, HabitTreeDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // Migration scripts will be added here in future sprints.
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
