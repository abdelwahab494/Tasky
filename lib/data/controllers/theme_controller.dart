// import 'package:tasky/core/imports.dart';

// class ThemeController extends ChangeNotifier {
//   ThemeMode _theme = ThemeMode.dark;

//   ThemeMode get theme => _theme;
//   bool get isDark => _theme == ThemeMode.dark;

//   ThemeController() {
//     init();
//   }

//   Future<void> init() async {
//     final bool dark = await PrefHelper.getTheme() ?? true;
//     _theme = dark ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }

//   Future<void> toggleTheme() async {
//     if (_theme == ThemeMode.dark) {
//       _theme = ThemeMode.light;
//       await PrefHelper.saveTheme(false);
//     } else {
//       _theme = ThemeMode.dark;
//       await PrefHelper.saveTheme(true);
//     }
//     notifyListeners();
//   }
// }
