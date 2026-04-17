import 'package:tasky/core/imports.dart';
import 'package:tasky/core/di/injection_container.dart' as ic;

const platform = MethodChannel('com.example.tasky/update_widget');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  ic.init();
  await PrefHelper.init();
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
        ChangeNotifierProvider<NotesController>(
          create: (_) => NotesController(),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
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
    return Selector<ThemeController, ThemeMode>(
      selector: (context, controller) => controller.theme,
      builder: (context, themeMode, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              locale: const Locale("en"),
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
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
      },
    );
  }
}
