import 'package:tasky/core/imports.dart';

Future<void> tasksInjection() async {
  if (!getIt.isRegistered<Isar>()) {
    getIt.registerLazySingletonAsync<Isar>(() async {
      return await IsarHelper.init();
    });
  }

  await getIt.isReady<Isar>();

  getIt.registerLazySingleton<TasksLocalDatasource>(
    () => TasksIsarDatasource(getIt<Isar>()),
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
      deleteAllTasksUsecase: getIt(),
    ),
  );
}
