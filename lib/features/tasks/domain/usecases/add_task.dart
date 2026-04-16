import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class AddTaskUsecase implements UseCase<Unit, TaskParams> {
  final TasksRepo repo;

  AddTaskUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call( params) {
    final String id = params.id ?? const Uuid().v4();
    final DateTime createdAt = params.createdAt ?? DateTime.now();
    return repo.addTask(
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
