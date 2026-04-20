import '../../../../core/usecases/usecase.dart';
import '../entities/habit_entity.dart';
import '../repositories/habit_repository.dart';

class GetHabitByIdUseCase implements UseCase<HabitEntity?, String> {
  final HabitRepository _repository;
  GetHabitByIdUseCase(this._repository);

  @override
  Future<HabitEntity?> call(String params) => _repository.getHabitById(params);
}
