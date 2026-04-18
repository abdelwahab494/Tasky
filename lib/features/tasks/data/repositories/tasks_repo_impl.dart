import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class TasksRepoImpl implements TasksRepo {
  final TasksLocalDatasource source;

  TasksRepoImpl(this.source);

  @override
  Future<Either<Failure, Unit>> addTask(TaskEntity task) async {
    try {
      final TaskModel model = TaskModel.fromEntity(task);
      await source.addTask(model);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(String id) async {
    try {
      await source.deleteTask(id);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> loadTasks() async {
    try {
      final List<TaskModel> tasksModelList = await source.getTasks();
      final List<TaskEntity> tasksList = tasksModelList
          .map((task) => task.toEntity())
          .toList();
      return Right(tasksList);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTask(TaskEntity task) async {
    try {
      final TaskModel model = TaskModel.fromEntity(task);
      await source.updateTask(model);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAllTasks() async {
    try {
      await source.deleteAllTasks();
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
