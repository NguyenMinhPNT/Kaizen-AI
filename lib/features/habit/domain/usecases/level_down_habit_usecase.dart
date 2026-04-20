import '../../../../core/usecases/usecase.dart';
import '../repositories/habit_repository.dart';

class LevelDownHabitUseCase implements UseCase<void, String> {
  final HabitRepository _repository;
  LevelDownHabitUseCase(this._repository);

  @override
  Future<void> call(String params) => _repository.levelDownHabit(params);
}
