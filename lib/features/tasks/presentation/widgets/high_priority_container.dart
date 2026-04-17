import 'package:tasky/core/imports.dart';

class HighPriorityContainer extends StatelessWidget {
  const HighPriorityContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return SliverToBoxAdapter(
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoaded) {
            if (state.highPriorityTasks.isNotEmpty) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w8,
                  vertical: AppSizes.w8,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.r20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: AppSizes.w8,
                              bottom: AppSizes.h8,
                            ),
                            child: Row(
                              spacing: AppSizes.w8,
                              children: [
                                Text(
                                  s.highPriorityTasks,
                                  style: GoogleFonts.poppins(
                                    fontSize: AppSizes.sp14,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  "(${state.highPriorityTasks.length} ${s.tasks})",
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .copyWith(fontSize: AppSizes.sp10),
                                ),
                              ],
                            ),
                          ),
                          ...List.generate(
                            state.highPriorityTasks.length <= 3
                                ? state.highPriorityTasks.length
                                : 3,
                            (index) {
                              final TaskEntity priorityTask =
                                  state.highPriorityTasks[index];
                              return Row(
                                    spacing: AppSizes.w8,
                                    children: [
                                      SizedBox(
                                        width: AppSizes.w30,
                                        height: AppSizes.h30,
                                        child: CustomCheckBox(
                                          value: priorityTask.isDone,
                                          onChanged: (value) =>
                                              context.read<TasksBloc>().add(
                                                TaskUpdateRequested(
                                                  TaskParams.fromEntity(
                                                    priorityTask,
                                                  ).copyWith(
                                                    isDone:
                                                        !priorityTask.isDone,
                                                  ),
                                                ),
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
                                  )
                                  .animate()
                                  .fadeIn(
                                    duration: Duration(
                                      milliseconds: 100 + index * 30,
                                    ),
                                  )
                                  .slideX(
                                    duration: Duration(
                                      milliseconds: 100 + index * 30,
                                    ),
                                    begin: 0.2,
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                    if (state.highPriorityTasks.length > 2)
                      const ShowMoreButton(),
                  ],
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}

class ShowMoreButton extends StatelessWidget {
  const ShowMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (c) => const PriorityPage()));
      },
      child: Container(
        width: AppSizes.w40,
        height: AppSizes.h40,
        margin: EdgeInsets.all(AppSizes.w8),
        decoration: BoxDecoration(
          border: Border.all(width: AppSizes.w1, color: DarkColors.text4),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.arrow_outward_outlined, size: AppSizes.r23),
      ),
    );
  }
}
