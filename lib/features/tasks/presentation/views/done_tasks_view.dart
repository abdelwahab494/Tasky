import 'package:tasky/core/imports.dart';

class DoneTasksView extends StatelessWidget {
  const DoneTasksView({super.key});

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
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                if (state is TasksLoaded) {
                  if (state.doneTasks.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: FittedBox(
                          child: SizedBox(
                            width: AppSizes.w160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FittedBox(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      AppSizes.w60,
                                      AppSizes.h0,
                                      AppSizes.w60,
                                      AppSizes.h20,
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/icons/completed.svg",
                                      colorFilter: ColorFilter.mode(
                                        Theme.of(context).primaryColor,
                                        BlendMode.srcIn,
                                      ),
                                      width: 250,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    s.noCompletedTasks,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: AppSizes.sp500,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    s.timetomakeprogress,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontSize: AppSizes.sp500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
