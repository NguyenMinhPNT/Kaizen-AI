import 'dart:math';
import '../../../../features/habit/domain/enums/habit_status.dart';
import '../../../../features/habit/domain/repositories/habit_repository.dart';
import '../repositories/timer_repository.dart';

class FinishTimerUseCase {
  final TimerRepository _timerRepo;
  final HabitRepository _habitRepo;

  FinishTimerUseCase({
    required TimerRepository timerRepo,
    required HabitRepository habitRepo,
  })  : _timerRepo = timerRepo,
        _habitRepo = habitRepo;

  Future<void> call({
    required String habitId,
    required int targetSeconds,
  }) async {
    // 1. Stop service + clear prefs
    await _timerRepo.stopService();
    await _timerRepo.clearSession();

    final targetMinutes = (targetSeconds / 60).ceil().clamp(1, 9999);
    final now = DateTime.now();

    // 2. Log the session as completed (100%)
    await _habitRepo.logTimerSession(
      habitId: habitId,
      targetMinutes: targetMinutes,
      actualMinutes: targetMinutes,
      status: HabitStatus.completed,
      completionPct: 100.0,
      date: now,
    );

    // 3. Update streak + totalCompletedDays
    await _updateStreak(habitId, now);
  }

  Future<void> _updateStreak(String habitId, DateTime now) async {
    final habit = await _habitRepo.getHabitById(habitId);
    if (habit == null) return;

    // Check yesterday's log to determine streak continuity
    final yesterday = now.subtract(const Duration(days: 1));
    final yesterdayLog = await _habitRepo.getLogForDate(habitId, yesterday);
    final wasYesterdayCompleted = yesterdayLog?.status == HabitStatus.completed;

    final newStreak = wasYesterdayCompleted ? habit.currentStreak + 1 : 1;
    final newLongest = max(habit.longestStreak, newStreak);

    await _habitRepo.updateHabit(
      habit.copyWith(
        currentStreak: newStreak,
        longestStreak: newLongest,
        totalCompletedDays: habit.totalCompletedDays + 1,
        updatedAt: now,
      ),
    );
  }
}
