import '../repositories/timer_repository.dart';

class PauseTimerUseCase {
  final TimerRepository _repo;

  PauseTimerUseCase(this._repo);

  Future<void> call(int elapsedSeconds) => _repo.pauseSession(elapsedSeconds);
}
