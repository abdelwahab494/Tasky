import 'package:tasky/core/imports.dart';

Future<void> userInjection() async {
  if (!getIt.isRegistered<Isar>()) {
    getIt.registerLazySingletonAsync<Isar>(() async {
      return await IsarHelper.init();
    });
  }

  await getIt.isReady<Isar>();

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

  getIt.registerLazySingleton(() => GetCurrentUserUsecase(getIt()));
  getIt.registerLazySingleton(() => LoginUsecase(getIt()));
  getIt.registerLazySingleton(() => LogoutUsecase(getIt()));
  getIt.registerLazySingleton(() => SaveUserUsecase(getIt()));
  getIt.registerLazySingleton(() => PickImageUsecase(getIt()));

  getIt.registerFactory(
    () => UserBloc(
      getCurrentUserUsecase: getIt(),
      loginUsecase: getIt(),
      logoutUsecase: getIt(),
      saveUserUsecase: getIt(),
      pickImageUsecase: getIt(),
    ),
  );
}
