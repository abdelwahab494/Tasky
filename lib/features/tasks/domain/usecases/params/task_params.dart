import 'package:tasky/core/imports.dart';

class TaskParams extends Equatable {
  final String? id;
  final String taskName;
  final String? taskDesc;
  final bool isHighPriority;
  final bool isDone;
  final DateTime? createdAt;

  const TaskParams({
    this.id,
    required this.taskName,
    this.taskDesc,
    required this.isHighPriority,
    required this.isDone,
    this.createdAt,
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

  TaskParams copyWith({
    String? id,
    String? taskName,
    String? taskDesc,
    bool? isHighPriority,
    bool? isDone,
  }) {
    return TaskParams(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      taskDesc: taskDesc ?? this.taskDesc,
      isHighPriority: isHighPriority ?? this.isHighPriority,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt,
    );
  }
}
