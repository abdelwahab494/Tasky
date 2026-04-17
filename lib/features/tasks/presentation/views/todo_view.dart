import 'package:tasky/core/imports.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.w16,
          AppSizes.h20,
          AppSizes.w16,
          AppSizes.h0,
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverCustomAppbar(title: s.toDoTasks),
            SliverGap(AppSizes.h20),
            BlocConsumer<TasksBloc, TasksState>(
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
                  if (state.todoTasks.isEmpty) {
                    return TaskEmptyView(
                      svgPath: AppAssets.iconsTodo,
                      title: s.noTasksToDo,
                      subTitle: s.takesomerestfornow,
                    );
                  }
                  return SliverList.separated(
                    itemCount: state.todoTasks.length,
                    itemBuilder: (context, index) {
                      final TaskEntity task = state.todoTasks[index];
                      return TaskContainer(task: task)
                          .animate()
                          .fadeIn(
                            duration: Duration(milliseconds: 100 + index * 30),
                          )
                          .scale(
                            duration: Duration(milliseconds: 100 + index * 30),
                            begin: const Offset(0.8, 0.8),
                          );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Gap(AppSizes.h8),
                  );
                }
                return const SliverToBoxAdapter();
              },
            ),
          ],
        ),
      ),
    );
  }
}
