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

  const TaskUpdateRequested(this.task);

  @override
  List<Object> get props => [task];
}

class TaskDeleteRequested extends TasksEvent {
  final TaskParams task;

  const TaskDeleteRequested(this.task);

  @override
  List<Object> get props => [task];
}