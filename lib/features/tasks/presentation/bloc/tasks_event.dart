part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class TasksLoadRequested extends TasksEvent {}

class TaskAddRequested extends TasksEvent {
  final TaskParams task;

  const TaskAddRequested(this.task);

  @override
  List<Object> get props => [task];
}

class TaskUpdateRequested extends TasksEvent {
  final TaskParams task;
  final bool? silent;

  const TaskUpdateRequested(this.task, {this.silent});

  @override
  List<Object> get props => [task];
}

class TaskDeleteRequested extends TasksEvent {
  final String id;

  const TaskDeleteRequested(this.id);

  @override
  List<Object> get props => [id];
}

class TasksSortToggled extends TasksEvent {}

class TasksDeleteAll extends TasksEvent {}
