import 'package:tasky/core/imports.dart';

class UserDatailsPage extends StatelessWidget {
  const UserDatailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserBloc>(),
      child: const UserDetailsView(),
    );
  }
}
