import 'package:tasky/core/imports.dart';

Future<void> settingsInjection() async {
    if (!getIt.isRegistered<Isar>()) {
    getIt.registerLazySingletonAsync<Isar>(() async {
      return await IsarHelper.init();
    });
  }

  await getIt.isReady<Isar>();


  getIt.registerLazySingleton<SettingsDatasource>(
    () => SettingsIsarDatasource(getIt<Isar>()),
  );

  getIt.registerLazySingleton<SettingsRepo>(
    () => SettingsRepoImpl(getIt<SettingsDatasource>()),
  );

  getIt.registerLazySingleton(() => GetSettingsUsecase(getIt()));
  getIt.registerLazySingleton(() => ToggleThemeUsecase(getIt()));

  getIt.registerFactory(
    () =>
        SettingsBloc(getSettingsUsecase: getIt(), toggleThemeUsecase: getIt()),
  );
}
