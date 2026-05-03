import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class UpdateTaskUsecase implements UseCase<Unit, TaskEntity> {
  final TasksRepo repo;

  const UpdateTaskUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await repo.updateTask(params);
  }
}
