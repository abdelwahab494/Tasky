import 'package:tasky/core/imports.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TasksBloc>()..add(TasksLoadRequested()),
      child: const TodoView(),
    );
  }
}
