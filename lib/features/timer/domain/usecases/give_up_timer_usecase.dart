import '../../../../features/habit/domain/enums/habit_status.dart';
import '../../../../features/habit/domain/repositories/habit_repository.dart';
import '../repositories/timer_repository.dart';

class GiveUpTimerUseCase {
  final TimerRepository _timerRepo;
  final HabitRepository _habitRepo;

  GiveUpTimerUseCase({
    required TimerRepository timerRepo,
    required HabitRepository habitRepo,
  })  : _timerRepo = timerRepo,
        _habitRepo = habitRepo;

  Future<void> call({
    required String habitId,
    required int elapsedSeconds,
    required int targetSeconds,
    DateTime? date,
  }) async {
    // 1. Stop service + clear prefs
    await _timerRepo.stopService();
    await _timerRepo.clearSession();

    // 2. Log the session as gave_up
    final completionPct = targetSeconds > 0
        ? (elapsedSeconds / targetSeconds * 100.0).clamp(0.0, 100.0)
        : 0.0;
    final actualMinutes = (elapsedSeconds / 60).floor();
    final targetMinutes = (targetSeconds / 60).ceil().clamp(1, 9999);
    final logDate = date ?? DateTime.now();

    await _habitRepo.logTimerSession(
      habitId: habitId,
      targetMinutes: targetMinutes,
      actualMinutes: actualMinutes,
      status: HabitStatus.gaveUp,
      completionPct: completionPct,
      date: logDate,
    );
  }
}
