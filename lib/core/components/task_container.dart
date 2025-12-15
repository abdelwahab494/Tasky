import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasky/core/imports.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
    required this.togglePriority,
  });
  final TaskModel task;
  final Function(bool? value) onChanged;
  final Function() onDelete;
  final Function() onEdit;
  final Function() togglePriority;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(task.hashCode),
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onEdit();
            },
            icon: Icons.mode_edit_outline_rounded,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onDelete();
            },
            icon: Icons.clear_rounded,
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
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
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 7, bottom: 7, right: 4, left: 4),
          child: Row(
            spacing: 8,
            children: [
              CustomCheckBox(
                value: task.isDone,
                onChanged: (value) async {
                  onChanged(value);
                },
              ),
              Expanded(
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
              Gap(8),
              PopupMenuButton(
                itemBuilder: (context) {
                  return <PopupMenuItem>[
                    PopupMenuItem(
                      onTap: () => onChanged(!task.isDone),
                      child: PopUpMenueItemChild(
                        text: task.isDone ? "Not Done" : "Done",
                        icon: task.isDone
                            ? Icons.check_box_outline_blank_rounded
                            : Icons.check_box_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () => togglePriority(),
                      child: PopUpMenueItemChild(
                        text: task.isHighPriority ? "Normal" : "High Priority",
                        icon: task.isHighPriority
                            ? CupertinoIcons.minus_circle
                            : CupertinoIcons.exclamationmark_circle_fill,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () => onEdit(),
                      child: PopUpMenueItemChild(
                        text: "Edit Task",
                        icon: CupertinoIcons.square_pencil_fill,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () => onDelete(),
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
      spacing: 15,
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
