import 'package:tasky/core/imports.dart';

class SettingsEntity extends Equatable {
  final int? isarId;

  final ThemeMode themeMode;

  const SettingsEntity({this.isarId, required this.themeMode});

  @override
  List<Object?> get props => [isarId, themeMode];
}
