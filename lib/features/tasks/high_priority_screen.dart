import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController()..init(),
      child: Scaffold(
        appBar: AppBar(title: Text("High Priority Tasks")),
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
            return controller.highPriorityTasksList.isEmpty
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
                              "No High Priority Tasks",
                              style: GoogleFonts.poppins(
                                color: DarkColors.text2,
                                fontWeight: FontWeight.w400,
                                fontSize: 500,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "Relax for now",
                              style: GoogleFonts.poppins(
                                color: DarkColors.text3,
                                fontWeight: FontWeight.w400,
                                fontSize: 500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: controller.highPriorityTasksList.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    itemBuilder: (context, index) {
                      final TaskModel task =
                          controller.highPriorityTasksList[index];
                      return TaskContainer(
                        task: task,
                        onChanged: (bool? value) =>
                            controller.onChanged(value: value, task: task),
                        onDelete: () {
                          controller.onDelete(
                            context: context,
                            task: task,
                            showDeletingMessage: (ctx, ctrl) {
                              Dialogs.showDeletingMessage(
                                context: ctx,
                                controller: ctrl,
                              );
                            },
                          );
                        },
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
