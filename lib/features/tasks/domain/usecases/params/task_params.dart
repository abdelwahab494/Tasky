// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tasky/core/imports.dart';

class TaskParams {
  final String? id;
  final String taskName;
  final String? taskDesc;
  final bool isHighPriority;
  final bool isDone;
  final DateTime? createdAt;

  TaskParams({
    this.id,
    required this.taskName,
    this.taskDesc,
    required this.isHighPriority,
    required this.isDone,
    this.createdAt,
  });

  factory TaskParams.fromEntity(TaskEntity task) {
    return TaskParams(
      id: task.id,
      taskName: task.taskName,
      taskDesc: task.taskDesc,
      isHighPriority: task.isHighPriority,
      isDone: task.isDone,
    );
  }

  TaskParams copyWith({
    String? id,
    String? taskName,
    String? taskDesc,
    bool? isHighPriority,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return TaskParams(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      taskDesc: taskDesc ?? this.taskDesc,
      isHighPriority: isHighPriority ?? this.isHighPriority,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
