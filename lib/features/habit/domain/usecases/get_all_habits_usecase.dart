import '../../../../core/usecases/usecase.dart';
import '../entities/habit_entity.dart';
import '../repositories/habit_repository.dart';

class GetAllHabitsUseCase implements UseCase<List<HabitEntity>, NoParams> {
  final HabitRepository _repository;
  GetAllHabitsUseCase(this._repository);

  @override
  Future<List<HabitEntity>> call(NoParams params) => _repository.getAllHabits();

  Stream<List<HabitEntity>> watch() => _repository.watchAllHabits();
}
