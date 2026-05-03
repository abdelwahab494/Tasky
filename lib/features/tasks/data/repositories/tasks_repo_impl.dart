import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class TasksRepoImpl implements TasksRepo {
  final TasksLocalDatasource tasksSource;
  final SessionHelper session;

  const TasksRepoImpl(this.tasksSource, this.session);

  @override
  Future<Either<Failure, Unit>> addTask(TaskEntity task) async {
    try {
      final TaskModel model = TaskModel.fromEntity(task);
      final user = await session.getCurrentUser();
      await tasksSource.addTask(user, model);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(int? isarId) async {
    try {
      await tasksSource.deleteTask(isarId);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    try {
      final user = await session.getCurrentUser();
      final List<TaskModel> tasksModelList = await tasksSource.getTasks(user);
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
      final user = await session.getCurrentUser();
      await tasksSource.updateTask(user, model);
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
      final user = await session.getCurrentUser();
      await tasksSource.deleteAllTasks(user);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, HomeUserEntity>> getCurrentUser() async {
    try {
      final user = await session.getCurrentUser();
      final HomeUserEntity userEntity = HomeUserEntity(
        name: user.name,
        imagePath: user.image,
        quote: user.quote,
      );
      return Right(userEntity);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
