import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverPadding(
            padding: EdgeInsets.only(top: 20),
            sliver: SliverCustomAppbar(title: "High Priority Tasks"),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: Consumer<HomeController>(
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
                return controller.highPriorityTasksList.isEmpty
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
                                      "No High Priority Tasks",
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
                                      "Relax for now",
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
                        itemCount: controller.highPriorityTasksList.length,
                        itemBuilder: (context, index) {
                          final TaskModel task =
                              controller.highPriorityTasksList[index];
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
          ),
        ],
      ),
    );
  }
}
