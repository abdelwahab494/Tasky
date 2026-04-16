part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

final class TasksLoaded extends TasksState {
  final List<TaskEntity> tasksList;

  List<TaskEntity> get doneTasks =>
      tasksList.where((task) => task.isDone).toList();
  List<TaskEntity> get todoTasks =>
      tasksList.where((task) => !task.isDone).toList();
  List<TaskEntity> get highPriorityTasks =>
      tasksList.where((task) => task.isHighPriority).toList();

  const TasksLoaded(this.tasksList);

  @override
  List<Object> get props => [
    tasksList,
    doneTasks,
    todoTasks,
    highPriorityTasks,
  ];
}

final class TasksError extends TasksState {
  final String message;

  const TasksError(this.message);

  @override
  List<Object> get props => [message];
}

final class TasksSuccess extends TasksState {
  final String? message;

  const TasksSuccess({required this.message});
}
