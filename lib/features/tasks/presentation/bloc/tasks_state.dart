part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

final class TasksLoaded extends TasksState {
  final List<TaskEntity> tasksList;
  final SortTypeEnum sortType;

  List<TaskEntity> get sortedTasks {
    if (sortType == SortTypeEnum.descending) {
      return tasksList.reversed.toList();
    }
    return tasksList;
  }

  List<TaskEntity> get doneTasks =>
      tasksList.where((task) => task.isDone).toList();
  List<TaskEntity> get todoTasks =>
      tasksList.where((task) => !task.isDone).toList();
  List<TaskEntity> get highPriorityTasks =>
      tasksList.where((task) => task.isHighPriority).toList();
  EncourageEnum get encourage {
    if (doneTasks.isNotEmpty && doneTasks.length == tasksList.length) {
      return EncourageEnum.isDone;
    } else if (doneTasks.isNotEmpty && doneTasks.length < tasksList.length) {
      return EncourageEnum.isGoing;
    } else if (tasksList.isEmpty) {
      return EncourageEnum.begin;
    } else {
      return EncourageEnum.started;
    }
  }

  const TasksLoaded(this.tasksList, {this.sortType = SortTypeEnum.ascending});

  @override
  List<Object> get props => [
    tasksList,
    doneTasks,
    todoTasks,
    highPriorityTasks,
    sortType,
  ];
}

final class TasksError extends TasksState {
  final String message;

  const TasksError(this.message);

  @override
  List<Object> get props => [message];
}

final class TasksSuccess extends TasksState {
  final String message;

  const TasksSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
