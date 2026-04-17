import 'package:tasky/core/imports.dart';

class DoneView extends StatelessWidget {
  const DoneView({super.key});

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
            SliverCustomAppbar(title: s.completedTasks),
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
                  if (state.doneTasks.isEmpty) {
                    return TaskEmptyView(
                      svgPath: AppAssets.iconsCompleted,
                      title: s.noCompletedTasks,
                      subTitle: s.timetomakeprogress,
                    );
                  }
                  return SliverList.separated(
                    itemCount: state.doneTasks.length,
                    itemBuilder: (context, index) {
                      final TaskEntity task = state.doneTasks[index];
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
