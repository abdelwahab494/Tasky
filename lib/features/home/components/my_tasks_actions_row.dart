import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart' hide ShimmerEffect;

class MyTasksActionsRow extends StatelessWidget {
  const MyTasksActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return SliverToBoxAdapter(
      child: Consumer<HomeController>(
        builder: (context, controller, child) {
          return Skeletonizer(
            enabled: controller.isLoading,
            child: controller.tasksList.isNotEmpty
                ? Row(
                    children: [
                      Expanded(
                        child: Text(
                          s.myTasks,
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontSize: AppSizes.sp20),
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
                              tooltip: controller.sortList
                                  ? s.sortDown
                                  : s.sortUp,
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                foregroundColor: Theme.of(
                                  context,
                                ).textTheme.titleMedium!.color,
                              ),
                            ),
                            Container(
                              height: AppSizes.h22,
                              width: AppSizes.w1,
                              margin: EdgeInsets.symmetric(
                                horizontal: AppSizes.w5,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                if (controller.tasksList.isNotEmpty) {
                                  final bool?
                                  result = await Dialogs.showDeletAlertDialog(
                                    context: context,
                                    title: s.deleteAllTasks,
                                    contentText:
                                        s.alltaskswillbedeletedpermanently,
                                    action: s.delete,
                                  );
                                  if (result == true) {
                                    await PrefHelper.clearTasksList();
                                    controller.loadData();
                                  }
                                }
                              },
                              tooltip: s.deleteAllTasks,
                              icon: const Icon(Icons.clear_all_rounded),
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
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
