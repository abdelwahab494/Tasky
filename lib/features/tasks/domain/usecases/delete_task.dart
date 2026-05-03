import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class DeleteTaskUsecase implements UseCase<Unit, int?> {
  final TasksRepo repo;

  DeleteTaskUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(isarId) {
    return repo.deleteTask(isarId);
  }
}
