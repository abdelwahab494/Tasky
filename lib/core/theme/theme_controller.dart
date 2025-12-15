import 'package:tasky/core/imports.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  static Future<void> init() async {
    bool isDark = await PrefHelper.getTheme() ?? true;
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PrefHelper.saveTheme(false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PrefHelper.saveTheme(true);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}
