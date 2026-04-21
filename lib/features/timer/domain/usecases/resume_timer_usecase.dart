import '../repositories/timer_repository.dart';

class ResumeTimerUseCase {
  final TimerRepository _repo;

  ResumeTimerUseCase(this._repo);

  /// Returns the current elapsed seconds (computed from saved start epoch + paused snapshot).
  Future<int> call({
    required String habitName,
    required int remainingSeconds,
  }) =>
      _repo.resumeSession(
        habitName: habitName,
        remainingSeconds: remainingSeconds,
      );
}
