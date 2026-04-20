import 'package:equatable/equatable.dart';
import '../enums/habit_status.dart';

class HabitLogEntity extends Equatable {
  final String id;
  final String habitId;
  final DateTime date;
  final HabitStatus status;
  final int durationMinutes;
  final String? note;
  final DateTime createdAt;

  const HabitLogEntity({
    required this.id,
    required this.habitId,
    required this.date,
    required this.status,
    required this.durationMinutes,
    this.note,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        habitId,
        date,
        status,
        durationMinutes,
        note,
        createdAt,
      ];
}
