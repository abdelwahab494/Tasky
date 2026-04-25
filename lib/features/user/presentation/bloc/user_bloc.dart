import 'dart:async';

import 'package:tasky/core/imports.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final SaveUserUsecase saveUserUsecase;

  UserBloc({
    required this.getCurrentUserUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.saveUserUsecase,
  }) : super(UserInitial()) {
    on<CurrentUserRequested>(_onCurrentUserRequested);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCurrentUserRequested(
    CurrentUserRequested event,
    Emitter<UserState> emit,
  ) async {
    final result = await getCurrentUserUsecase(NoParams());

    result.fold((failure) => emit(const UserError("Error Loading User!")), (
      user,
    ) {
      if (user == null) {
        emit(const UserError("Error Loading User!"));
        return;
      }
      emit(UserLoaded(currentUser: user));
    });
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<UserState> emit,
  ) async {
    final result = await loginUsecase(event.params);

    result.fold(
      (failure) => emit(const UserError("Failed To Login!")),
      (_) => emit(const UserSuccess("Welcome Back")),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<UserState> emit,
  ) async {
    final result = await logoutUsecase(NoParams());

    result.fold(
      (failure) => emit(const UserError("Failed To Log Out!")),
      (_) => emit(const UserSuccess("Logged Out Successfully")),
    );
  }
}
