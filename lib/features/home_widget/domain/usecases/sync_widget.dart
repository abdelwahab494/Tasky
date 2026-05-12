import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

@LazySingleton()
class SyncWidgetUsecase extends UseCase<Unit, SyncWidgetParams> {
  final TasksWidgetRepo repo;

  SyncWidgetUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(SyncWidgetParams params) async {
    return repo.syncTasksToWidget(params.tasks);
  }
}

class SyncWidgetParams {
  final List<TaskEntity> tasks;

  SyncWidgetParams(this.tasks);
}
