import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/enums/level_up_mode.dart';
import '../../domain/enums/tree_type.dart';

extension HabitModelMapper on Habit {
  HabitEntity toEntity() => HabitEntity(
        id: id.toString(),
        name: name,
        description: description ?? '',
        iconCode: iconCode,
        colorHex: colorHex,
        currentDurationMinutes: currentDurationMinutes,
        maxDurationMinutes: maxDurationMinutes,
        incrementMinutes: incrementMinutes,
        treeType: _parseTreeType(treeType),
        levelUpMode: _parseLevelUpMode(levelUpMode),
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        totalCompletedDays: totalCompletedDays,
        isArchived: isArchived,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  static TreeType _parseTreeType(String value) {
    return TreeType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TreeType.oak,
    );
  }

  static LevelUpMode _parseLevelUpMode(String value) {
    return LevelUpMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => LevelUpMode.manual,
    );
  }
}

extension HabitEntityMapper on HabitEntity {
  HabitsCompanion toCompanion() {
    final numId = int.tryParse(id);
    return HabitsCompanion(
      id: numId != null ? Value(numId) : const Value.absent(),
      name: Value(name),
      description: Value(description.isEmpty ? null : description),
      iconCode: Value(iconCode),
      colorHex: Value(colorHex),
      currentDurationMinutes: Value(currentDurationMinutes),
      maxDurationMinutes: Value(maxDurationMinutes),
      incrementMinutes: Value(incrementMinutes),
      treeType: Value(treeType.name),
      levelUpMode: Value(levelUpMode.name),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      totalCompletedDays: Value(totalCompletedDays),
      isArchived: Value(isArchived),
      updatedAt: Value(DateTime.now()),
    );
  }
}
