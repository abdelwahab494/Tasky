import 'package:tasky/core/imports.dart';

class TasksModel {
  final String taskName;
  final String? taskDesc;
  bool isHighPriority;
  bool isDone;

  TasksModel({
    required this.taskName,
    this.taskDesc,
    required this.isHighPriority,
    this.isDone = false,
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) => TasksModel(
    taskName: json["taskName"] ?? "",
    taskDesc: json["taskDesc"] ?? "",
    isHighPriority: json["isHighPriority"] as bool? ?? false,
    isDone: json["isDone"] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    "taskName": taskName,
    "taskDesc": taskDesc ?? "",
    "isHighPriority": isHighPriority,
    "isDone": isDone,
  };

  TaskEntity toEntity() {
    return TaskEntity(
      id: const Uuid().v4(),
      taskName: taskName,
      taskDesc: taskDesc,
      isHighPriority: isHighPriority,
      isDone: isDone,
      createdAt: DateTime.now(),
    );
  }
}
