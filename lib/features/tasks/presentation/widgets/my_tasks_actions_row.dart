import 'package:flutter/cupertino.dart';
import 'package:tasky/core/imports.dart';

class MyTasksActionsRow extends StatelessWidget {
  const MyTasksActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return SliverToBoxAdapter(
      child: BlocBuilder<TasksBloc, TasksState>(
        buildWhen: (previous, current) => current is TasksLoaded,
        builder: (context, state) {
          if (state is TasksLoaded && state.sortedTasks.isNotEmpty) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    s.myTasks,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontSize: AppSizes.sp20),
                  ),
                ),
                if (state.sortedTasks.isNotEmpty)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () =>
                            context.read<TasksBloc>().add(TasksSortToggled()),
                        icon: Icon(
                          state.sortType == SortTypeEnum.ascending
                              ? CupertinoIcons.sort_down
                              : CupertinoIcons.sort_up,
                        ),
                        tooltip: state.sortType == SortTypeEnum.ascending
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
                        margin: EdgeInsets.symmetric(horizontal: AppSizes.w5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (state.sortedTasks.isNotEmpty) {
                            final TasksBloc bloc = context.read<TasksBloc>();
                            final bool? result =
                                await Dialogs.showDeletAlertDialog(
                                  context: context,
                                  title: s.deleteAllTasks,
                                  contentText:
                                      s.alltaskswillbedeletedpermanently,
                                  action: s.delete,
                                );
                            if (result == true) {
                              bloc.add(TasksDeleteAll());
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
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
