import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasky/core/imports.dart';
import 'package:tasky/data/enums/task_pop_up_enum.dart';
import 'package:tasky/features/tasks/presentation/widgets/edit_bottom_sheet.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({super.key, required this.task});
  final TaskEntity task;

  Future<void> editTask(BuildContext context) async {
    final TasksBloc bloc = context.read<TasksBloc>();

    final bool? result = await showModalBottomSheet<bool?>(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: bloc,
        child: EditBottomSheet(task: task),
      ),
    );

    if (result == true) {
      bloc.add(TasksLoadRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(task.hashCode),
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => editTask(context),
            icon: Icons.mode_edit_outline_rounded,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.r20),
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) =>
                context.read<TasksBloc>().add(TaskDeleteRequested(task.id)),
            icon: Icons.clear_rounded,
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.r20),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: AppSizes.w1,
          ),
          borderRadius: BorderRadius.circular(AppSizes.r20),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: AppSizes.h7,
            bottom: AppSizes.h7,
            right: AppSizes.w4,
            left: AppSizes.w4,
          ),
          child: Row(
            spacing: AppSizes.w8,
            children: [
              CustomCheckBox(
                value: task.isDone,
                onChanged: (value) => context.read<TasksBloc>().add(
                  TaskUpdateRequested(
                    TaskParams(
                      id: task.id,
                      taskName: task.taskName,
                      taskDesc: task.taskDesc,
                      isDone: !task.isDone,
                      isHighPriority: task.isHighPriority,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => editTask(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        task.taskName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: task.isDone
                            ? Theme.of(context).textTheme.labelMedium
                            : Theme.of(context).textTheme.titleMedium,
                      ),
                      if (task.taskDesc != null && task.taskDesc!.isNotEmpty)
                        Text(
                          task.taskDesc ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: task.isDone
                              ? Theme.of(context).textTheme.labelSmall
                              : Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                ),
              ),
              Gap(AppSizes.w8),
              PopupMenuButton(
                onSelected: (value) async {
                  final TasksBloc bloc = context.read<TasksBloc>();
                  switch (value) {
                    case TaskPopUpEnum.done:
                      bloc.add(
                        TaskUpdateRequested(
                          TaskParams(
                            id: task.id,
                            taskName: task.taskName,
                            taskDesc: task.taskDesc,
                            isHighPriority: task.isHighPriority,
                            isDone: !task.isDone,
                            createdAt: task.createdAt,
                          ),
                        ),
                      );
                      break;
                    case TaskPopUpEnum.priority:
                      bloc.add(
                        TaskUpdateRequested(
                          TaskParams(
                            id: task.id,
                            taskName: task.taskName,
                            taskDesc: task.taskDesc,
                            isHighPriority: !task.isHighPriority,
                            isDone: task.isDone,
                            createdAt: task.createdAt,
                          ),
                        ),
                      );
                      break;
                    case TaskPopUpEnum.edit:
                      editTask(context);
                      break;
                    case TaskPopUpEnum.delete:
                      bloc.add(TaskDeleteRequested(task.id));
                      break;
                  }
                },
                itemBuilder: (context) {
                  return <PopupMenuItem>[
                    PopupMenuItem(
                      value: TaskPopUpEnum.done,
                      child: PopUpMenueItemChild(
                        text: task.isDone ? "Not Done" : "Done",
                        icon: task.isDone
                            ? Icons.check_box_outline_blank_rounded
                            : Icons.check_box_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    PopupMenuItem(
                      value: TaskPopUpEnum.priority,
                      child: PopUpMenueItemChild(
                        text: task.isHighPriority ? "Normal" : "High Priority",
                        icon: task.isHighPriority
                            ? CupertinoIcons.minus_circle
                            : CupertinoIcons.exclamationmark_circle_fill,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    PopupMenuItem(
                      value: TaskPopUpEnum.edit,
                      child: PopUpMenueItemChild(
                        text: "Edit Task",
                        icon: CupertinoIcons.square_pencil_fill,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    PopupMenuItem(
                      value: TaskPopUpEnum.delete,
                      child: PopUpMenueItemChild(
                        text: "Delete Task",
                        icon: CupertinoIcons.trash,
                        color: Colors.red.shade600,
                      ),
                    ),
                  ];
                },
                iconColor: task.isDone
                    ? Theme.of(context).textTheme.labelMedium!.color
                    : Theme.of(context).textTheme.titleMedium!.color,
                style: IconButton.styleFrom(side: BorderSide.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopUpMenueItemChild extends StatelessWidget {
  const PopUpMenueItemChild({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSizes.w15,
      children: [
        Icon(icon, color: color),
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
