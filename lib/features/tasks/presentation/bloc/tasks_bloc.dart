import 'package:tasky/core/imports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final AddTaskUsecase addTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;
  final GetTasksUsecase getTasksUsecase;

  TasksBloc({
    required this.addTaskUsecase,
    required this.updateTaskUsecase,
    required this.deleteTaskUsecase,
    required this.getTasksUsecase,
  }) : super(TasksInitial()) {
    on<TasksLoadRequested>(_onTasksLoadRequested);
    on<TaskAddRequested>(_onTaskAddRequested);
    on<TaskUpdateRequested>(_onTaskUpdateRequested);
    on<TaskDeleteRequested>(_onTaskDeleteRequested);
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
}
