part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class CurrentUserRequested extends UserEvent {}

class LoginRequested extends UserEvent {
  final LoginParams params;

  const LoginRequested(this.params);
}

class LogoutRequested extends UserEvent {}
