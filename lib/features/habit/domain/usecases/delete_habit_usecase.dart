import '../../../../core/usecases/usecase.dart';
import '../repositories/habit_repository.dart';

class DeleteHabitUseCase implements UseCase<void, String> {
  final HabitRepository _repository;
  DeleteHabitUseCase(this._repository);

  @override
  Future<void> call(String params) => _repository.deleteHabit(params);
}
