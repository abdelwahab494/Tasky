import 'package:tasky/core/imports.dart';

class UserDatailsPage extends StatelessWidget {
  const UserDatailsPage({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserBloc>(),
      child: UserDetailsView(user: user),
    );
  }
}
