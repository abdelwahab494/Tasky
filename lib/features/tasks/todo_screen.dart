import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController()..init(),
      child: Scaffold(
        appBar: AppBar(title: Text("To Do Tasks")),
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
                      onChanged: (bool? value) {},
                      onDelete: () {},
                      onEdit: () {},
                      togglePriority: () {},
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Gap(8),
                ),
              );
            }
            return controller.toDoTasksList.isEmpty
                ? Center(
                    child: SizedBox(
                      width: 160,
                      height: 170,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FittedBox(
                            child: Text(
                              "No More Tasks To Do",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium!.copyWith(fontSize: 500),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "You've completed all tasks",
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
                    itemCount: controller.toDoTasksList.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    itemBuilder: (context, index) {
                      final TaskModel task = controller.toDoTasksList[index];
                      return TaskContainer(
                        task: task,
                        onChanged: (bool? value) =>
                            controller.onChanged(value: value, task: task),
                        onDelete: () => controller.onDelete(
                          context: context,
                          task: task,
                          showDeletingMessage: (ctx, ctrl) {
                            Dialogs.showDeletingMessage(
                              context: ctx,
                              controller: ctrl,
                            );
                          },
                        ),
                        onEdit: () =>
                            controller.onEdit(context: context, task: task),
                        togglePriority: () =>
                            controller.togglePriority(task: task),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Gap(8),
                  );
          },
        ),
      ),
    );
  }
}
