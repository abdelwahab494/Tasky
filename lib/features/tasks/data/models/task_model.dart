import 'package:hive/hive.dart';
import 'package:tasky/features/tasks/domain/entities/task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String taskName;
  @HiveField(2)
  final String? taskDesc;
  @HiveField(3)
  final bool isHighPriority;
  @HiveField(4)
  final bool isDone;
  @HiveField(5)
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDesc,
    required this.isHighPriority,
    required this.isDone,
    required this.createdAt
  });

  factory TaskModel.fromEntity(TaskEntity task) {
    return TaskModel(
      id: task.id,
      taskName: task.taskName,
      taskDesc: task.taskDesc,
      isHighPriority: task.isHighPriority,
      isDone: task.isDone,
      createdAt: task.createdAt
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      taskName: taskName,
      taskDesc: taskDesc,
      isHighPriority: isHighPriority,
      isDone: isDone,
      createdAt: createdAt
    );
  }
}
