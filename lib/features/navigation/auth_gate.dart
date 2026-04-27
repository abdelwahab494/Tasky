import 'package:tasky/core/imports.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserBloc>()..add(CurrentUserRequested()),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          }
          if (state is UserLoaded) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NavRoot()),
            );
          }
        },
        child: const Scaffold(
          // body: Center(
          //   child: CircularProgressIndicator(
          //     color: Theme.of(context).primaryColor,
          //   ),
          // ),
        ),
      ),
    );
  }
}
