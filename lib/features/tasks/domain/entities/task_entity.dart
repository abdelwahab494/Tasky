import 'package:tasky/core/imports.dart';

class TaskEntity extends Equatable {
  final String id;
  final String taskName;
  final String? taskDesc;
  final bool isHighPriority;
  final bool isDone;
  final DateTime createdAt;

  const TaskEntity({
    required this.id,
    required this.taskName,
    required this.taskDesc,
    required this.isHighPriority,
    required this.isDone,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    taskName,
    taskDesc,
    isHighPriority,
    isDone,
    createdAt,
  ];
}
