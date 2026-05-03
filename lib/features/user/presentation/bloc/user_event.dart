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

class ChangeAvatarRequested extends UserEvent {
  final ImageActionsEnum action;
  final SaveUserParams params;

  const ChangeAvatarRequested({required this.params,  required this.action});
}

class SaveUserRequested extends UserEvent{
  final SaveUserParams params;

  const SaveUserRequested(this.params);
}