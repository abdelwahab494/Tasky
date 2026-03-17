import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart';

class MyTasksSection extends StatelessWidget {
  const MyTasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return SliverSkeletonizer(
            child: SliverPadding(
              padding: EdgeInsets.only(bottom: AppSizes.h80),
              sliver: SliverList.separated(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return TaskContainer(
                    task: TaskModel(
                      taskName: s.taskName,
                      isHighPriority: false,
                    ),
                    controller: controller,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Gap(AppSizes.h8),
              ),
            ),
          );
        }
        return controller.tasksList.isEmpty
            ? SliverFillRemaining(
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
                                "assets/icons/todo.svg",
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).primaryColor,
                                  BlendMode.srcIn,
                                ),
                                width: AppSizes.w250,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              s.noTasksYet,
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(fontSize: AppSizes.sp500),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              s.startyourfirstone,
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(fontSize: AppSizes.sp500),
                            ),
                          ),
                        ],
                      ),
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
                //       const Gap(AppSizes.h8),
                // ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: controller.tasksList.length,
                    (context, index) {
                      final TaskModel task = controller.tasksList[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSizes.h4),
                        child: TaskContainer(task: task, controller: controller)
                            .animate()
                            .fadeIn(
                              duration: Duration(
                                milliseconds: 100 + index * 30,
                              ),
                            )
                            .scale(
                              duration: Duration(
                                milliseconds: 100 + index * 30,
                              ),
                              begin: const Offset(0.8, 0.8),
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
