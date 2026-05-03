import 'package:tasky/core/imports.dart';

class PriorityPage extends StatelessWidget {
  const PriorityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TasksBloc>()..add(TasksLoadRequested()),
      child: const PriorityView(),
    );
  }
}
