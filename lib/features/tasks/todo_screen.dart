import 'package:tasky/core/imports.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TaskModel> tasksList = [];
  List<TaskModel> toDoTasksList = [];
  List<TaskModel> tasksListBeforeDeleting = [];
  bool showMessage = false;

  @override
  void initState() {
    super.initState();
    _loadData();
    Future.delayed(Duration(seconds: 1), () {
      if (toDoTasksList.isEmpty) {
        setState(() => showMessage = true);
      }
    });
  }

  Future<void> _loadData() async {
    final List<TaskModel> fetchedTasksList = await PrefHelper.getTasksList();

    if (mounted) {
      setState(() {
        tasksList = fetchedTasksList;
        toDoTasksList = tasksList
            .where((element) => element.isDone == false)
            .toList();
        showMessage = tasksList.isEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do Tasks")),
      body: showMessage
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
                        "No More Tasks To Do",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(fontSize: 500),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        "You've completed all tasks",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall!.copyWith(fontSize: 500),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              itemCount: toDoTasksList.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (context, index) {
                final TaskModel task = toDoTasksList[index];
                return TaskContainer(
                  task: task,
                  onChanged: (bool? value) async {
                    setState(() => task.isDone = value!);
                    await PrefHelper.updateTasksList(tasksList);
                    _loadData();
                  },
                  onDelete: () async {
                    setState(
                      () => tasksListBeforeDeleting = List.from(tasksList),
                    );
                    tasksList.removeWhere((e) => e == task);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Task Deleted Successfully.",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondaryContainer,
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        action: SnackBarAction(
                          label: "Undo",
                          onPressed: () async {
                            await PrefHelper.updateTasksList(
                              tasksListBeforeDeleting,
                            );
                            _loadData();
                          },
                          textColor: Theme.of(
                            context,
                          ).textTheme.titleMedium!.color,
                        ),
                      ),
                    );
                    await PrefHelper.updateTasksList(tasksList);
                    _loadData();
                  },
                  onEdit: () async {
                    final bool? result = await Dialogs.showEditTaskSheet(
                      context: context,
                      task: task,
                    );
                    if (result == true) {
                      _loadData();
                    }
                  },
                  togglePriority: () async {
                    setState(() {
                      task.isHighPriority = !task.isHighPriority;
                    });
                    await PrefHelper.updateTasksList(tasksList);
                    _loadData();
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) => Gap(8),
            ),
    );
  }
}
