import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverCustomAppbar(title: "Completed Tasks"),
            const SliverGap(20),
            Consumer<HomeController>(
              builder: (context, controller, child) {
                if (controller.isLoading) {
                  return SliverSkeletonizer(
                    child: ListView.separated(
                      itemCount: 4,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
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
                  );
                }
                return controller.completedTasksList.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: FittedBox(
                            child: SizedBox(
                              width: 160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FittedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        60,
                                        0,
                                        60,
                                        20,
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
                                      "No Completed Tasks",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontSize: 500,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Time to make progress",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(fontSize: 500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : SliverList.separated(
                        itemCount: controller.completedTasksList.length,
                        itemBuilder: (context, index) {
                          final TaskModel task =
                              controller.completedTasksList[index];
                          return TaskContainer(
                                task: task,
                                controller: controller,
                              )
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
                              );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Gap(8),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
