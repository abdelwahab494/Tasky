import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart' hide ShimmerEffect;

class HighPriorityContainer extends StatelessWidget {
  const HighPriorityContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return Skeletonizer(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            child: Row(
                              spacing: 8,
                              children: [
                                Text(
                                  "High Priority Tasks",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  "(5 tasks)",
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .copyWith(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          ...List.generate(2, (index) {
                            return Row(
                              spacing: 8,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CustomCheckBox(
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Task 1 Description",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    if (controller.highPriorityTasksList.length > 2)
                      ShowMoreButton(controller: controller),
                  ],
                ),
              ),
            );
          }
          return controller.highPriorityTasksList.isNotEmpty
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                bottom: 8,
                              ),
                              child: Row(
                                spacing: 8,
                                children: [
                                  Text(
                                    "High Priority Tasks",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "(${controller.highPriorityTasksList.length} tasks)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            ...List.generate(
                              controller.highPriorityTasksList.length <= 4
                                  ? controller.highPriorityTasksList.length
                                  : 4,
                              (index) {
                                final TaskModel priorityTask =
                                    controller.highPriorityTasksList[index];
                                return Row(
                                  spacing: 8,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CustomCheckBox(
                                        value: priorityTask.isDone,
                                        onChanged: (value) =>
                                            controller.onChanged(
                                              value: value,
                                              task: priorityTask,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        priorityTask.taskName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: priorityTask.isDone
                                            ? Theme.of(
                                                context,
                                              ).textTheme.labelMedium
                                            : Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      if (controller.highPriorityTasksList.length > 2)
                        ShowMoreButton(controller: controller),
                    ],
                  ),
                )
              : SizedBox.shrink();
        },
      ),
    );
  }
}

class ShowMoreButton extends StatelessWidget {
  const ShowMoreButton({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (c) => HighPriorityScreen()));
        controller.loadData();
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: DarkColors.text4),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.arrow_outward_outlined, size: 23),
      ),
    );
  }
}
