import 'package:tasky/core/imports.dart';

class DoneTasksPage extends StatelessWidget {
  const DoneTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TasksBloc>()..add(TasksLoadRequested()),
      child: const DoneTasksView(),
    );
  }
}
