import 'package:tasky/core/imports.dart';

Future<void> noteInjection() async {
  if (!getIt.isRegistered<Isar>()) {
    getIt.registerLazySingletonAsync<Isar>(() async {
      return await IsarHelper.init();
    });
  }

  await getIt.isReady<Isar>();

  getIt.registerLazySingleton<NotesLocalDatasource>(
    () => NotesIsarDatasource(getIt<Isar>()),
  );

  getIt.registerLazySingleton<NotesRepo>(
    () => NotesRepoImpl(getIt<NotesLocalDatasource>()),
  );

  getIt.registerLazySingleton(() => GetNotesUsecase(getIt<NotesRepo>()));
  getIt.registerLazySingleton(() => AddNoteUsecase(getIt<NotesRepo>()));
  getIt.registerLazySingleton(() => DeleteAllNotesUsecase(getIt<NotesRepo>()));
  getIt.registerLazySingleton(() => DeleteNotesUsecase(getIt<NotesRepo>()));
  getIt.registerLazySingleton(() => UpdateNoteUsecase(getIt<NotesRepo>()));

  getIt.registerFactory<NotesBloc>(
    () => NotesBloc(
      getNotesUsecase: getIt(),
      addNoteUsecase: getIt(),
      deleteAllTasksUsecase: getIt(),
      deleteNotesUsecase: getIt(),
      updateNoteUsecase: getIt(),
    ),
  );
}
