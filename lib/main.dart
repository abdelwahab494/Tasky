import 'package:tasky/core/imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();
  await ThemeController.init();
  final String? name = await PrefHelper.getName();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(
          create: (_) => HomeController()..init(),
        ),
        ChangeNotifierProvider<UserDetailsController>(
          create: (_) => UserDetailsController(),
        ),
        ChangeNotifierProvider<WelcomeController>(
          create: (_) => WelcomeController(),
        ),
      ],
      child: MyApp(initialName: name),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? initialName;

  const MyApp({super.key, this.initialName});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          home: initialName == null || initialName!.isEmpty
              ? const WelcomeScreen()
              : const NavRoot(),
        );
      },
    );
  }
}
