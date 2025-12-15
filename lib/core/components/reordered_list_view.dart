// Future<void> reorderTasksList(int oldIndex, int newIndex) async {
//   if (oldIndex < newIndex) {
//     newIndex -= 1;
//   }

//   setState(() {
//     final TaskModel task = completedTasksList.removeAt(
//       oldIndex,
//     );
//     completedTasksList.insert(newIndex, task);
//     final int globalOldIndex = tasksList.indexWhere((t) => t == task);
//     tasksList.removeAt(globalOldIndex);
//     tasksList.insert(globalOldIndex + (newIndex - oldIndex), task);
//   });

//   await PrefHelper.updateTasksList(tasksList);
// }

// : ReorderableListView.builder(
//     itemCount: completedTasksList.length,
//     shrinkWrap: true,
//     physics: NeverScrollableScrollPhysics(),
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//     buildDefaultDragHandles:
//         true,
//     onReorder: reorderTasksList,
//     itemBuilder: (context, index) {
//       final TaskModel task = completedTasksList[index];
//       return Padding(
//         key: ValueKey(task.hashCode),
//         padding: const EdgeInsets.only(bottom: 8),
//         child: TaskContainer(
//           task: task,
//           onChanged: (bool? value) async {
//             setState(() => task.isDone = value!);
//             await PrefHelper.updateTasksList(tasksList);
//             _loadData();
//           },
//           onDelete: () async {
//             setState(
//               () => tasksListBeforeDeleting = List.from(tasksList),
//             );
//             tasksList.removeWhere((e) => e == task);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                   "Task Deleted Successfully.",
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//                 backgroundColor: Theme.of(
//                   context,
//                 ).colorScheme.secondaryContainer,
//                 margin: EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 8,
//                 ),
//                 behavior: SnackBarBehavior.floating,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 0,
//                 action: SnackBarAction(
//                   label: "Undo",
//                   onPressed: () async {
//                     await PrefHelper.updateTasksList(
//                       tasksListBeforeDeleting,
//                     );
//                     _loadData();
//                   },
//                   textColor: Theme.of(
//                     context,
//                   ).textTheme.titleMedium!.color,
//                 ),
//               ),
//             );
//             await PrefHelper.updateTasksList(tasksList);
//             _loadData();
//           },
//         ),
//       );
//     },
//   ),
