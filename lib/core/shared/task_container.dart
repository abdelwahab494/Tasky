import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasky/core/imports.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    super.key,
    required this.task,
    required this.controller,
  });
  final TaskModel task;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(task.hashCode),
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) =>
                controller.onEdit(context: context, task: task),
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
            onPressed: (context) => controller.onDelete(
              context: context,
              task: task,
              showDeletingMessage: (ctx, ctrl) {
                Dialogs.showDeletingMessage(context: ctx, controller: ctrl);
              },
            ),
            icon: Icons.clear_rounded,
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.r20),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        // padding: EdgeInsets.only(top: 7, bottom: 7, right: 4, left: 4),
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
                onChanged: (value) =>
                    controller.onChanged(value: value, task: task),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.onEdit(context: context, task: task),
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
                itemBuilder: (context) {
                  return <PopupMenuItem>[
                    PopupMenuItem(
                      onTap: () =>
                          controller.onChanged(value: !task.isDone, task: task),
                      child: PopUpMenueItemChild(
                        text: task.isDone ? "Not Done" : "Done",
                        icon: task.isDone
                            ? Icons.check_box_outline_blank_rounded
                            : Icons.check_box_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () => controller.togglePriority(task: task),
                      child: PopUpMenueItemChild(
                        text: task.isHighPriority ? "Normal" : "High Priority",
                        icon: task.isHighPriority
                            ? CupertinoIcons.minus_circle
                            : CupertinoIcons.exclamationmark_circle_fill,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () =>
                          controller.onEdit(context: context, task: task),
                      child: PopUpMenueItemChild(
                        text: "Edit Task",
                        icon: CupertinoIcons.square_pencil_fill,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () => controller.onDelete(
                        context: context,
                        task: task,
                        showDeletingMessage: (ctx, ctrl) {
                          Dialogs.showDeletingMessage(
                            context: ctx,
                            controller: ctrl,
                          );
                        },
                      ),
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
