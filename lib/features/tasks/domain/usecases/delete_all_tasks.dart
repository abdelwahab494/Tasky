import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

@LazySingleton()
class DeleteAllTasksUsecase implements UseCase<Unit, NoParams> {
  final TasksRepo repo;

  DeleteAllTasksUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(params) {
    return repo.deleteAllTasks();
  }
}
