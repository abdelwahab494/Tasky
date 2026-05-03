import 'package:tasky/core/imports.dart';
import 'package:tasky/core/di/injection_container.dart' as ic;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.init();
  await ic.getIt.allReady();
  await PrefHelper.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              home: const AuthGate(),
            );
          },
        );
      },
    );
  }
}
