import 'package:tasky/core/imports.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserBloc>(),
      child: const LoginView(),
    );
  }
}
