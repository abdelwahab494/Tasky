import 'package:tasky/core/imports.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserBloc>()..add(CurrentUserRequested()),
      child: const ProfileView(),
    );
  }
}
