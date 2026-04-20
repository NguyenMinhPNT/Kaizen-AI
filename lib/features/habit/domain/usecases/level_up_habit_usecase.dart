import '../../../../core/usecases/usecase.dart';
import '../repositories/habit_repository.dart';

class LevelUpHabitUseCase implements UseCase<void, String> {
  final HabitRepository _repository;
  LevelUpHabitUseCase(this._repository);

  @override
  Future<void> call(String params) => _repository.levelUpHabit(params);
}
