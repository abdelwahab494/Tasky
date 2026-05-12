part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class GetSettingsRequested extends SettingsEvent {}

class ToggleThemeRequested extends SettingsEvent {
  final ToggleThemeParams params;

  const ToggleThemeRequested(this.params);
}
