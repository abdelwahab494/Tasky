import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class DeleteTaskUsecase implements UseCase<Unit, TaskParams> {
  final TasksRepo repo;

  DeleteTaskUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(params) {
    final id = params.id ?? const Uuid().v4();
    final createdAt = DateTime.now();
    return repo.deleteTask(
      TaskEntity(
        id: id,
        taskName: params.taskName,
        taskDesc: params.taskDesc,
        isHighPriority: params.isHighPriority,
        isDone: params.isDone,
        createdAt: createdAt,
      ),
    );
  }
}
