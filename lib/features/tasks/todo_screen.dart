import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

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
            Consumer<HomeController>(
              builder: (context, controller, child) {
                if (controller.isLoading) {
                  return SliverSkeletonizer(
                    child: ListView.separated(
                      itemCount: 4,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.w16,
                        vertical: AppSizes.h16,
                      ),
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
                  );
                }
                return controller.toDoTasksList.isEmpty
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
                                      s.noTasksToDo,
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
                                      s.takesomerestfornow,
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
                      )
                    : SliverList.separated(
                        itemCount: controller.toDoTasksList.length,
                        itemBuilder: (context, index) {
                          final TaskModel task =
                              controller.toDoTasksList[index];
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
                            Gap(AppSizes.h8),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
