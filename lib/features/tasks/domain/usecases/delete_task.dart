import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class DeleteTaskUsecase implements UseCase<Unit, String> {
  final TasksRepo repo;

  DeleteTaskUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(id) {
    return repo.deleteTask(id);
  }
}
