import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

abstract class TasksWidgetRepo {
  Future<Either<Failure, Unit>> syncTasksToWidget(List<TaskEntity> tasks);
}