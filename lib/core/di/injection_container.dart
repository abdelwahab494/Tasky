import 'package:tasky/core/imports.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: "init",
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependency(String env) async => await getIt.init(environment: env);

abstract class Env {
  static const String prod = "prod";
}
