import 'dart:async';
import 'package:tasky/core/imports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final AddTaskUsecase addTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;
  final GetTasksUsecase getTasksUsecase;
  final DeleteAllTasksUsecase deleteAllTasksUsecase;

  TasksBloc({
    required this.addTaskUsecase,
    required this.updateTaskUsecase,
    required this.deleteTaskUsecase,
    required this.getTasksUsecase,
    required this.deleteAllTasksUsecase,
  }) : super(TasksInitial()) {
    on<TasksLoadRequested>(_onTasksLoadRequested);
    on<TaskAddRequested>(_onTaskAddRequested);
    on<TaskUpdateRequested>(_onTaskUpdateRequested);
    on<TaskDeleteRequested>(_onTaskDeleteRequested);
    on<TasksSortToggled>(_onTasksSortToggled);
    on<TasksDeleteAll>(_onTasksDeleteAll);
  }

  Future<void> _reload(Emitter<TasksState> emit) async {
    final tasksResult = await getTasksUsecase(NoParams());

    tasksResult.fold(
      (failure) => emit(const TasksError("Failed To Load Tasks")),
      (tasksList) => emit(TasksLoaded(tasksList)),
    );
  }

  Future<void> _onTasksLoadRequested(
    TasksLoadRequested event,
    Emitter<TasksState> emit,
  ) async {
    await _reload(emit);
  }

  Future<void> _onTaskAddRequested(
    TaskAddRequested event,
    Emitter<TasksState> emit,
  ) async {
    final addTaskResult = await addTaskUsecase(event.task);

    if (addTaskResult.isLeft()) {
      emit(const TasksError("Failed To Add This Task!"));
      return;
    }

    await _reload(emit);
  }

  Future<void> _onTaskUpdateRequested(
    TaskUpdateRequested event,
    Emitter<TasksState> emit,
  ) async {
    final updateTaskResult = await updateTaskUsecase(event.task);

    if (updateTaskResult.isLeft()) {
      emit(const TasksError("Failed To Edit This Task!"));
      return;
    }

    await _reload(emit);
  }

  Future<void> _onTaskDeleteRequested(
    TaskDeleteRequested event,
    Emitter<TasksState> emit,
  ) async {
    final deleteTaskResult = await deleteTaskUsecase(event.task);

    if (deleteTaskResult.isLeft()) {
      emit(const TasksError("Failed To Delete This Task!"));
      return;
    }

    await _reload(emit);
  }

  Future<void> _onTasksSortToggled(
    TasksSortToggled event,
    Emitter<TasksState> emit,
  ) async {
    if (state is TasksLoaded) {
      final currentState = state as TasksLoaded;

      final newSortType = currentState.sortType == SortTypeEnum.ascending
          ? SortTypeEnum.descending
          : SortTypeEnum.ascending;

      emit(TasksLoaded(currentState.tasksList, sortType: newSortType));
    }
  }

  Future<void> _onTasksDeleteAll(
    TasksDeleteAll event,
    Emitter<TasksState> emit,
  ) async {
    final deleteAllResult = await deleteAllTasksUsecase(NoParams());

    if (deleteAllResult.isLeft()) {
      emit(const TasksError("Failed To Delete All Tasks!"));
      return;
    }

    await _reload(emit);
  }
}
