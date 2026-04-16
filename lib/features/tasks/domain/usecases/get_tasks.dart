import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class GetTasksUsecase implements UseCase<List<TaskEntity>, NoParams> {
  final TasksRepo repo;

  GetTasksUsecase(this.repo);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(params) {
    return repo.loadTasks();
  }
}
