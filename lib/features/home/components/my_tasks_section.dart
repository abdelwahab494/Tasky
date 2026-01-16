import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart';

class MyTasksSection extends StatelessWidget {
  const MyTasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return SliverSkeletonizer(
            child: SliverPadding(
              padding: const EdgeInsets.only(bottom: 80),
              sliver: SliverList.separated(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return TaskContainer(
                    task: TaskModel(
                      taskName: "taskName",
                      isHighPriority: false,
                    ),
                    controller: controller,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Gap(8),
              ),
            ),
          );
        }
        return controller.tasksList.isEmpty
            ? SliverFillRemaining(
                child: Center(
                  child: SizedBox(
                    width: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(60, 0, 60, 20),
                            child: SvgPicture.asset(
                              "assets/icons/todo.svg",
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
                            "No Tasks Yet",
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(fontSize: 500),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            "Start your first one",
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(fontSize: 500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SliverPadding(
                padding: const EdgeInsets.only(bottom: 80),
                // sliver: SliverList.separated(
                //   itemCount: controller.tasksList.length,
                //   itemBuilder: (context, index) {
                //     final TaskModel task = controller.tasksList[index];
                //     return TaskContainer(task: task, controller: controller);
                //   },
                //   separatorBuilder: (BuildContext context, int index) =>
                //       const Gap(8),
                // ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: controller.tasksList.length,
                    (context, index) {
                      final TaskModel task = controller.tasksList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: TaskContainer(
                          task: task,
                          controller: controller,
                        ),
                      );
                    },
                  ),
                ),
              );
      },
    );
  }
}
