import 'package:tasky/core/imports.dart';

class MyTasksSection extends StatelessWidget {
  const MyTasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return BlocConsumer<TasksBloc, TasksState>(
      listenWhen: (previous, current) =>
          current is TasksSuccess || current is TasksError,
      listener: (context, state) {
        if (state is TasksSuccess) {
          context.showSuccess(state.message);
        }
        if (state is TasksError) {
          context.showError(state.message);
        }
      },
      buildWhen: (previous, current) => current is TasksLoaded,
      builder: (context, state) {
        if (state is TasksLoaded) {
          if (state.sortedTasks.isEmpty) {
            return TaskEmptyView(
              svgPath: AppAssets.iconsTodo,
              title: s.noTasksYet,
              subTitle: s.startyourfirstone,
            );
          }
          return SliverPadding(
            padding: const EdgeInsets.only(bottom: 80),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: state.sortedTasks.length,
                (context, index) {
                  final TaskEntity task = state.sortedTasks[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSizes.h4),
                    child: TaskContainer(task: task)
                        .animate()
                        .fadeIn(
                          duration: Duration(milliseconds: 100 + index * 30),
                        )
                        .scale(
                          duration: Duration(milliseconds: 100 + index * 30),
                          begin: const Offset(0.8, 0.8),
                        ),
                  );
                },
              ),
            ),
          );
        }
        return const SliverToBoxAdapter();
      },
    );
  }
}
