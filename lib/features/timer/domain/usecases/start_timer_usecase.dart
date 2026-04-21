import '../repositories/timer_repository.dart';

class StartTimerUseCase {
  final TimerRepository _repo;

  StartTimerUseCase(this._repo);

  Future<void> call({
    required String habitId,
    required String habitName,
    required int targetSeconds,
  }) async {
    await _repo.startSession(
      habitId: habitId,
      habitName: habitName,
      targetSeconds: targetSeconds,
    );
  }
}
