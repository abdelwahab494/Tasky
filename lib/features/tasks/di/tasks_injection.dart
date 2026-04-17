import 'package:tasky/core/imports.dart';

Future<void> tasksInjection() async {
  getIt.registerLazySingleton<Box<TaskModel>>(() => HiveHelper.tasks);

  getIt.registerLazySingleton<TasksLocalDatasource>(
    () => TasksHiveDatasource(getIt()),
  );

  getIt.registerLazySingleton<TasksRepo>(() => TasksRepoImpl(getIt()));

  getIt.registerLazySingleton(() => AddTaskUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateTaskUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteTaskUsecase(getIt()));
  getIt.registerLazySingleton(() => GetTasksUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteAllTasksUsecase(getIt()));

  getIt.registerFactory(
    () => TasksBloc(
      addTaskUsecase: getIt(),
      updateTaskUsecase: getIt(),
      deleteTaskUsecase: getIt(),
      getTasksUsecase: getIt(),
      deleteAllTasksUsecase: getIt()
    ),
  );
}
