class TaskModel {
  final String taskName;
  final String? taskDesc;
  bool isHighPriority;
  bool isDone;

  TaskModel({
    required this.taskName,
    this.taskDesc,
    required this.isHighPriority,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
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
}
