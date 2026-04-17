import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

abstract class TasksRepo {
  Future<Either<Failure, Unit>> addTask(TaskEntity task);

  Future<Either<Failure, Unit>> updateTask(TaskEntity task);

  Future<Either<Failure, Unit>> deleteTask(String id);

  Future<Either<Failure, List<TaskEntity>>> loadTasks();

  Future<Either<Failure, Unit>> deleteAllTasks();
}
