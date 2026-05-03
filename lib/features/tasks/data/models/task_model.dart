import 'package:tasky/core/imports.dart';

part 'task_model.g.dart';

@collection
class TaskModel {
  Id isarId = Isar.autoIncrement;

  late String id;

  @Index()
  late String taskName;

  String? taskDesc;

  late bool isHighPriority;

  late bool isDone;

  late DateTime createdAt;

  final user = IsarLink<UserModel>();

  TaskModel();

  factory TaskModel.fromEntity(TaskEntity task) {
    return TaskModel()
      ..isarId = task.isarId ?? Isar.autoIncrement
      ..id = task.id
      ..taskName = task.taskName
      ..taskDesc = task.taskDesc
      ..isHighPriority = task.isHighPriority
      ..isDone = task.isDone
      ..createdAt = task.createdAt;
  }

  TaskEntity toEntity() {
    return TaskEntity(
      isarId: isarId,
      id: id,
      taskName: taskName,
      taskDesc: taskDesc,
      isHighPriority: isHighPriority,
      isDone: isDone,
      createdAt: createdAt,
    );
  }
}
