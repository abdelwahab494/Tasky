import 'package:tasky/core/imports.dart';

Future<void> tasksInjection() async {
  if (!getIt.isRegistered<Isar>()) {
    getIt.registerLazySingletonAsync<Isar>(() async {
      return await IsarHelper.init();
    });
  }

  await getIt.isReady<Isar>();

  getIt.registerLazySingleton<TasksWidgetDatasource>(
    () => TasksWidgetDatasourceImpl(getIt<Isar>()),
  );
  getIt.registerLazySingleton<TasksLocalDatasource>(
    () => TasksIsarDatasource(getIt<Isar>()),
  );
  if (!getIt.isRegistered<UserLocalDatasource>()) {
    getIt.registerLazySingleton<UserLocalDatasource>(
      () => UserIsarDatasource(getIt<Isar>()),
    );
  }
  if (!getIt.isRegistered<UserRepo>()) {
    getIt.registerLazySingleton<UserRepo>(
      () => UserRepoImpl(getIt<UserLocalDatasource>()),
    );
  }
  if (!getIt.isRegistered<SessionHelper>()) {
    getIt.registerLazySingleton<SessionHelper>(
      () => SessionHelper(getIt<UserRepo>(), getIt<Isar>()),
    );
  }

  getIt.registerLazySingleton<TasksRepo>(
    () => TasksRepoImpl(getIt<TasksLocalDatasource>(), getIt<SessionHelper>()),
  );
  getIt.registerLazySingleton<TasksWidgetRepo>(
    () => TasksWidgetRepoImpl(getIt<TasksWidgetDatasource>()),
  );

  getIt.registerLazySingleton(() => AddTaskUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateTaskUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteTaskUsecase(getIt()));
  getIt.registerLazySingleton(() => GetTasksUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteAllTasksUsecase(getIt()));
  getIt.registerLazySingleton(() => GetHomeUserUsecase(getIt()));
  getIt.registerLazySingleton(() => SyncWidgetUsecase(getIt()));

  getIt.registerFactory(
    () => TasksBloc(
      addTaskUsecase: getIt(),
      updateTaskUsecase: getIt(),
      deleteTaskUsecase: getIt(),
      getTasksUsecase: getIt(),
      deleteAllTasksUsecase: getIt(),
      getHomeUserUsecase: getIt(),
      syncWidgetUsecase: getIt(),
    ),
  );
}
