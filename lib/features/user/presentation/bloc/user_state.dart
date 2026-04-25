part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoaded extends UserState {
  final UserEntity currentUser;

  const UserLoaded({required this.currentUser});

  @override
  List<Object> get props => [currentUser];
}

final class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

final class UserSuccess extends UserState {
  final String message;

  const UserSuccess(this.message);

  @override
  List<Object> get props => [message];
}