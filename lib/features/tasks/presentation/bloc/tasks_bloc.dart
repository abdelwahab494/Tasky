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
  final GetHomeUserUsecase getHomeUserUsecase;

  TasksBloc({
    required this.addTaskUsecase,
    required this.updateTaskUsecase,
    required this.deleteTaskUsecase,
    required this.getTasksUsecase,
    required this.deleteAllTasksUsecase,
    required this.getHomeUserUsecase,
  }) : super(TasksInitial()) {
    on<TasksLoadRequested>(_onTasksLoadRequested);
    on<TaskAddRequested>(_onTaskAddRequested);
    on<TaskUpdateRequested>(_onTaskUpdateRequested);
    on<TaskDeleteRequested>(_onTaskDeleteRequested);
    on<TasksSortToggled>(_onTasksSortToggled);
    on<TasksDeleteAll>(_onTasksDeleteAll);
  }

  HomeUserEntity? _currentuser;

  Future<void> _reload(Emitter<TasksState> emit) async {
    final tasksResult = await getTasksUsecase(NoParams());

    if (_currentuser == null) {
      final userResult = await getHomeUserUsecase(NoParams());

      userResult.fold(
        (failure) => emit(const TasksError("Failed to Load User Details!")),
        (user) => _currentuser = user,
      );
    }

    tasksResult.fold(
      (failure) => emit(const TasksError("Failed To Load Tasks")),
      (tasksList) =>
          emit(TasksLoaded(tasksList: tasksList, currentUser: _currentuser!)),
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
    final String newId = const Uuid().v4();
    final DateTime now = DateTime.now();

    final TaskEntity newTask = TaskEntity(
      isarId: event.task.isarId,
      id: newId,
      taskName: event.task.taskName,
      taskDesc: event.task.taskDesc,
      isHighPriority: event.task.isHighPriority,
      isDone: event.task.isDone,
      createdAt: now,
    );

    final addTaskResult = await addTaskUsecase(newTask);

    addTaskResult.fold(
      (failure) => emit(const TasksError("Failed To Add This Task!")),
      (_) => emit(const TasksSuccess(message: "Task Added Successfully.")),
    );

    await _reload(emit);
  }

  Future<void> _onTaskUpdateRequested(
    TaskUpdateRequested event,
    Emitter<TasksState> emit,
  ) async {
    final DateTime now = DateTime.now();

    final TaskEntity updatedTask = TaskEntity(
      isarId: event.task.isarId,
      id: event.task.id!,
      taskName: event.task.taskName,
      taskDesc: event.task.taskDesc,
      isHighPriority: event.task.isHighPriority,
      isDone: event.task.isDone,
      createdAt: now,
    );

    final updateTaskResult = await updateTaskUsecase(updatedTask);

    updateTaskResult.fold(
      (failure) => emit(const TasksError("Failed To Edit This Task!")),
      (_) {
        if (event.silent == true) {
          emit(const TasksSuccess(message: "Task Updated Successfully."));
        }
      },
    );

    await _reload(emit);
  }

  Future<void> _onTaskDeleteRequested(
    TaskDeleteRequested event,
    Emitter<TasksState> emit,
  ) async {
    if (event.isarId == null) {
      emit(const TasksError("Failed To Delete This Task!"));
    }
    final deleteTaskResult = await deleteTaskUsecase(event.isarId);

    deleteTaskResult.fold(
      (failure) => emit(const TasksError("Failed To Delete This Task!")),
      (_) => emit(const TasksSuccess(message: "Task Deleted Successfully.")),
    );

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

      emit(
        currentState.copyWith(
          tasksList: currentState.tasksList,
          sortType: newSortType,
        ),
      );
    }
  }

  Future<void> _onTasksDeleteAll(
    TasksDeleteAll event,
    Emitter<TasksState> emit,
  ) async {
    final deleteAllResult = await deleteAllTasksUsecase(NoParams());

    deleteAllResult.fold(
      (failure) => emit(const TasksError("Failed To Delete All Tasks!")),
      (_) =>
          emit(const TasksSuccess(message: "All Tasks Deleted Successfully.")),
    );

    await _reload(emit);
  }
}
