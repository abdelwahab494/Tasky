import 'dart:async';

import 'package:tasky/core/imports.dart';

part 'user_event.dart';
part 'user_state.dart';

@Injectable()
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final SaveUserUsecase saveUserUsecase;
  final PickImageUsecase pickImageUsecase;

  UserBloc({
    required this.getCurrentUserUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.saveUserUsecase,
    required this.pickImageUsecase,
  }) : super(UserInitial()) {
    on<CurrentUserRequested>(_onCurrentUserRequested);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<ChangeAvatarRequested>(_onChangeAvatarRequested);
    on<SaveUserRequested>(_onSaveUserRequested);
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

  Future<void> _onChangeAvatarRequested(
    ChangeAvatarRequested event,
    Emitter<UserState> emit,
  ) async {
    if (event.action == ImageActionsEnum.delete) {
      final updatedParams = event.params.copyWith(
        user: event.params.user.copyWith(image: null),
      );

      final saveResult = await saveUserUsecase(updatedParams);

      saveResult.fold(
        (failure) => emit(const UserError("Failed To Remove Image!")),
        (_) {
          emit(const UserSuccess("Image Deleted Successfully"));
          emit(UserLoaded(currentUser: updatedParams.user));
        },
      );

      return;
    }

    final ImageSource source = switch (event.action) {
      ImageActionsEnum.gallery => ImageSource.gallery,
      ImageActionsEnum.camera => ImageSource.camera,
      ImageActionsEnum.delete => throw UnimplementedError(),
    };

    final pickImageResult = await pickImageUsecase(
      PickImageParams(imageSource: source),
    );

    await pickImageResult.fold(
      (failure) async {
        emit(const UserError("Failed To Pick Image"));
      },
      (path) async {
        if (path == null) {
          emit(const UserError("Image not selected"));
          return;
        }

        final updatedParams = event.params.copyWith(
          user: event.params.user.copyWith(image: path),
        );

        final saveResult = await saveUserUsecase(updatedParams);

        saveResult.fold(
          (failure) => emit(const UserError("Failed To Change Image!")),
          (_) {
            emit(const UserSuccess("Image Changes Successfully"));
            emit(UserLoaded(currentUser: updatedParams.user));
          },
        );
      },
    );
  }

  Future<void> _onSaveUserRequested(
    SaveUserRequested event,
    Emitter<UserState> emit,
  ) async {
    final result = await saveUserUsecase(event.params);

    result.fold(
      (failure) => emit(const UserError("Failed To Update Changes!")),
      (_) => emit(const UserSuccess("Changes Saved Successfully")),
    );
  }
}
