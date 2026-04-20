import 'package:tasky/core/imports.dart';

class TaskEntity extends Equatable {
  final int? isarId;
  final String id;
  final String taskName;
  final String? taskDesc;
  final bool isHighPriority;
  final bool isDone;
  final DateTime createdAt;

  const TaskEntity({
    this.isarId,
    required this.id,
    required this.taskName,
    this.taskDesc,
    required this.isHighPriority,
    required this.isDone,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    isarId,
    id,
    taskName,
    taskDesc,
    isHighPriority,
    isDone,
    createdAt,
  ];
}
