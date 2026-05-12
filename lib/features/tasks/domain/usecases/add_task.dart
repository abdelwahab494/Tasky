import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

@LazySingleton()
class AddTaskUsecase implements UseCase<Unit, TaskEntity> {
  final TasksRepo repo;

  const AddTaskUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(TaskEntity params) async {
    return await repo.addTask(params);
  }
}
