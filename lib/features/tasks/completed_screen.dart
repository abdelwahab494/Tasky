import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks")),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return Skeletonizer(
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
                separatorBuilder: (BuildContext context, int index) => Gap(8),
              ),
            );
          }
          return controller.completedTasksList.isEmpty
              ? Center(
                  child: SizedBox(
                    width: 180,
                    height: 170,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          child: Text(
                            "No Completed Tasks Yet",
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(fontSize: 500),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            "Time to make some progress",
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(fontSize: 500),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: controller.completedTasksList.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  itemBuilder: (context, index) {
                    final TaskModel task =
                        controller.completedTasksList[index];
                    return TaskContainer(
                      task: task,
                      controller: controller,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Gap(8),
                );
        },
      ),
    );
  }
}
