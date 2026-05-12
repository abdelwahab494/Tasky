part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  bool get isDark => themeMode == ThemeMode.dark;

  const SettingsState({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}
