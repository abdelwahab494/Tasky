import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart' hide ShimmerEffect;

class MyTasksActionsRow extends StatelessWidget {
  const MyTasksActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeController>(
        builder: (context, controller, child) {
          return Skeletonizer(
            enabled: controller.isLoading,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "My Tasks",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontSize: 20),
                  ),
                ),
                if (controller.tasksList.isNotEmpty)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => controller.toggleSortingList(),
                        icon: Icon(
                          controller.sortList
                              ? CupertinoIcons.sort_down
                              : CupertinoIcons.sort_up,
                        ),
                        tooltip: controller.sortList ? "Sort Down" : "Sort Up",
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          foregroundColor: Theme.of(
                            context,
                          ).textTheme.titleMedium!.color,
                        ),
                      ),
                      Container(
                        height: 22,
                        width: 1,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (controller.tasksList.isNotEmpty) {
                            final bool? result =
                                await Dialogs.showDeletAlertDialog(
                                  context: context,
                                  title: "Delete All Tasks",
                                  contentText:
                                      "All tasks will be deleted permanently.",
                                  action: "Delete",
                                );
                            if (result == true) {
                              await PrefHelper.clearTasksList();
                              controller.loadData();
                            }
                          }
                        },
                        tooltip: "Delete All Tasks",
                        icon: Icon(Icons.clear_all_rounded),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          foregroundColor: Theme.of(
                            context,
                          ).textTheme.titleMedium!.color,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
