import 'package:tasky/core/imports.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TasksBloc>(),
      child: const AddTaskView(),
    );
  }
}
