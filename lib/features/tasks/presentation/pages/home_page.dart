import 'package:tasky/core/imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TasksBloc>()
        ..add(TasksLoadRequested()),
      child: const HomeView(),
    );
  }
}
