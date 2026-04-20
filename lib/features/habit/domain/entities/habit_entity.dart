import 'package:equatable/equatable.dart';
import '../enums/level_up_mode.dart';
import '../enums/tree_type.dart';

class HabitEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final int iconCode;
  final String colorHex;
  final int currentDurationMinutes;
  final int maxDurationMinutes;
  final int incrementMinutes;
  final TreeType treeType;
  final LevelUpMode levelUpMode;
  final int currentStreak;
  final int longestStreak;
  final int totalCompletedDays;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  const HabitEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.iconCode,
    required this.colorHex,
    required this.currentDurationMinutes,
    required this.maxDurationMinutes,
    required this.incrementMinutes,
    required this.treeType,
    required this.levelUpMode,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalCompletedDays,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });

  HabitEntity copyWith({
    String? id,
    String? name,
    String? description,
    int? iconCode,
    String? colorHex,
    int? currentDurationMinutes,
    int? maxDurationMinutes,
    int? incrementMinutes,
    TreeType? treeType,
    LevelUpMode? levelUpMode,
    int? currentStreak,
    int? longestStreak,
    int? totalCompletedDays,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HabitEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconCode: iconCode ?? this.iconCode,
      colorHex: colorHex ?? this.colorHex,
      currentDurationMinutes:
          currentDurationMinutes ?? this.currentDurationMinutes,
      maxDurationMinutes: maxDurationMinutes ?? this.maxDurationMinutes,
      incrementMinutes: incrementMinutes ?? this.incrementMinutes,
      treeType: treeType ?? this.treeType,
      levelUpMode: levelUpMode ?? this.levelUpMode,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalCompletedDays: totalCompletedDays ?? this.totalCompletedDays,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        iconCode,
        colorHex,
        currentDurationMinutes,
        maxDurationMinutes,
        incrementMinutes,
        treeType,
        levelUpMode,
        currentStreak,
        longestStreak,
        totalCompletedDays,
        isArchived,
        createdAt,
        updatedAt,
      ];
}
