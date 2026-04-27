import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class TasksWidgetRepoImpl implements TasksWidgetRepo {
  final TasksWidgetDatasource source;

  TasksWidgetRepoImpl(this.source);

  @override
  Future<Either<Failure, Unit>> syncTasksToWidget(
    List<TaskEntity> tasks,
  ) async {
    try {
      final List<TaskModel> tasksModels = tasks
          .map((e) => TaskModel.fromEntity(e))
          .toList();
      await source.syncTasksToWidget(tasksModels);
      return const Right(unit);
    } catch (e) {
      return Left(WidgetFailure());
    }
  }
}
