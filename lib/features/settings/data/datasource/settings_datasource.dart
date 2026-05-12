import 'package:tasky/core/imports.dart';

sealed class SettingsDatasource {
  Future<SettingsModel> getSettings();

  Future<void> toggleTheme(bool value);
}

class SettingsIsarDatasource extends SettingsDatasource {
  final Isar isar;
  static const String settingsKey = "settingsKey";

  SettingsIsarDatasource(this.isar);

  @override
  Future<SettingsModel> getSettings() async {
    try {
      final settings = await isar.settingsModels.where().findFirst();

      final result = settings ?? (SettingsModel()..themeMode = ThemeMode.dark);

      return result;
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> toggleTheme(bool value) async {
    try {
      SettingsModel settings =
          await isar.settingsModels.where().findFirst() ??
          (SettingsModel()..themeMode = ThemeMode.dark);

      settings.themeMode = value ? ThemeMode.dark : ThemeMode.light;

      await isar.writeTxn(() async {
        await isar.settingsModels.put(settings);
      });

      await isar.settingsModels.where().findFirst();
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }
}
