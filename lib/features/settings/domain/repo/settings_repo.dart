import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

abstract class SettingsRepo {
  Future<Either<Failure, SettingsEntity>> getSettings();

  Future<Either<Failure, Unit>> toggleTheme(bool value);
}
