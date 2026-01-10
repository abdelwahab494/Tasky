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
              padding: EdgeInsets.only(bottom: 80),
              sliver: SliverList.separated(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return TaskContainer(
                    task: TaskModel(
                      taskName: "taskName",
                      isHighPriority: false,
                    ),
                    onChanged: (bool? value) {},
                    onDelete: () {},
                    onEdit: () {},
                    togglePriority: () {},
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Gap(8),
              ),
            ),
          );
        }
        return controller.tasksList.isEmpty
            ? SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Center(
                    child: SizedBox(
                      width: 110,
                      height: 170,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                ),
              )
            : SliverPadding(
                padding: EdgeInsets.only(bottom: 80),
                sliver: SliverList.separated(
                  itemCount: controller.tasksList.length,
                  itemBuilder: (context, index) {
                    final TaskModel task = controller.tasksList[index];
                    return TaskContainer(
                      task: task,
                      onChanged: (bool? value) =>
                          controller.onChanged(value: value, task: task),
                      onDelete: () => controller.onDelete(
                        task: task,
                        showDeletingMessage: Dialogs.showDeletingMessage(
                          context: context,
                          controller: controller,
                        ),
                      ),
                      onEdit: () =>
                          controller.onEdit(context: context, task: task),
                      togglePriority: () =>
                          controller.togglePriority(task: task),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Gap(8),
                ),
              );
      },
    );
  }
}
