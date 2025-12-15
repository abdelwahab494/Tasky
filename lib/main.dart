import 'package:tasky/core/imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();
  await ThemeController.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (BuildContext context, ThemeMode value, Widget? child) {
        return MaterialApp(
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeController.themeNotifier.value,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
