import '../../../../core/usecases/usecase.dart';
import '../repositories/habit_repository.dart';

class ArchiveHabitUseCase implements UseCase<void, String> {
  final HabitRepository _repository;
  ArchiveHabitUseCase(this._repository);

  @override
  Future<void> call(String params) => _repository.archiveHabit(params);
}
