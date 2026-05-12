import 'package:tasky/core/imports.dart';

@module
abstract class AppModule {
  @preResolve
  Future<Isar> get isar => IsarHelper.init();
}