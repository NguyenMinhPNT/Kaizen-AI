import '../../../../core/usecases/usecase.dart';
import '../entities/habit_entity.dart';
import '../repositories/habit_repository.dart';

class CreateHabitUseCase implements UseCase<void, HabitEntity> {
  final HabitRepository _repository;
  CreateHabitUseCase(this._repository);

  @override
  Future<void> call(HabitEntity params) => _repository.createHabit(params);
}
