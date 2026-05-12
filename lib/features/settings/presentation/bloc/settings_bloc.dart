import 'package:tasky/core/imports.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUsecase getSettingsUsecase;
  final ToggleThemeUsecase toggleThemeUsecase;

  SettingsBloc({
    required this.getSettingsUsecase,
    required this.toggleThemeUsecase,
  }) : super(const SettingsState(themeMode: ThemeMode.system)) {
    on<ToggleThemeRequested>(_onToggleThemeRequested);
    on<GetSettingsRequested>(_onGetSettingsRequested);
  }

  Future<void> _onToggleThemeRequested(
    ToggleThemeRequested event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await toggleThemeUsecase(event.params);

    result.fold(
      (failure) => emit(const SettingsState(themeMode: ThemeMode.dark)),
      (_) => emit(
        SettingsState(
          themeMode: event.params.value ? ThemeMode.dark : ThemeMode.light,
        ),
      ),
    );
  }

  Future<void> _onGetSettingsRequested(
    GetSettingsRequested event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await getSettingsUsecase(NoParams());

    result.fold(
      (failure) => emit(const SettingsState(themeMode: ThemeMode.dark)),
      (settings) => emit(SettingsState(themeMode: settings.themeMode)),
    );
  }
}
