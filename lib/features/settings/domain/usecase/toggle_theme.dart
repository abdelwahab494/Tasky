import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

@LazySingleton()
class ToggleThemeUsecase extends UseCase<Unit, ToggleThemeParams> {
  final SettingsRepo repo;

  ToggleThemeUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(ToggleThemeParams params) {
    return repo.toggleTheme(params.value);
  }
}

class ToggleThemeParams {
  final bool value;

  ToggleThemeParams({required this.value});
}
