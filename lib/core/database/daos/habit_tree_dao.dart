import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables.dart';

part 'habit_tree_dao.g.dart';

@DriftAccessor(tables: [HabitTrees])
class HabitTreeDao extends DatabaseAccessor<AppDatabase>
    with _$HabitTreeDaoMixin {
  HabitTreeDao(super.db);

  /// Returns all habit trees.
  Future<List<HabitTree>> getAllTrees() => select(habitTrees).get();

  /// Watches all habit trees — updates when any tree changes.
  Stream<List<HabitTree>> watchAllTrees() => select(habitTrees).watch();

  /// Returns the tree for a specific habit, or null if not yet created.
  Future<HabitTree?> getTreeForHabit(int habitId) =>
      (select(habitTrees)..where((t) => t.habitId.equals(habitId)))
          .getSingleOrNull();

  /// Inserts a new tree and returns its id.
  Future<int> insertTree(HabitTreesCompanion entry) =>
      into(habitTrees).insert(entry);

  /// Updates a tree row.
  Future<bool> updateTree(HabitTreesCompanion entry) =>
      update(habitTrees).replace(entry);

  /// Updates only the stage for a specific habit's tree.
  Future<int> updateStage(int habitId, int newStage) =>
      (update(habitTrees)..where((t) => t.habitId.equals(habitId))).write(
        HabitTreesCompanion(
          currentStage: Value(newStage),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Deletes the tree for a specific habit (called when habit is deleted).
  Future<int> deleteTreeForHabit(int habitId) =>
      (delete(habitTrees)..where((t) => t.habitId.equals(habitId))).go();
}
