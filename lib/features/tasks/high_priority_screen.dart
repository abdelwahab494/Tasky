import 'package:tasky/core/imports.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> tasksList = [];
  List<TaskModel> highPriorityTasksList = [];
  List<TaskModel> tasksListBeforeDeleting = [];
  bool showMessage = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> tasksListEncoded =
        prefs.getStringList("tasksList") ?? [];
    final List<TaskModel> storedList = [];
    for (dynamic singleTask in tasksListEncoded) {
      final TaskModel task = TaskModel.fromJson(jsonDecode(singleTask));
      storedList.add(task);
    }

    if (mounted) {
      setState(() {
        tasksList = storedList;
        highPriorityTasksList = tasksList.reversed
            .where((element) => element.isHighPriority)
            .toList();
      });
    }
    setState(() => showMessage = highPriorityTasksList.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
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
                        "No High Priority Tasks",
                        style: GoogleFonts.poppins(
                          color: DarkColors.text2,
                          fontWeight: FontWeight.w400,
                          fontSize: 500,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        "Relax for now",
                        style: GoogleFonts.poppins(
                          color: DarkColors.text3,
                          fontWeight: FontWeight.w400,
                          fontSize: 500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              itemCount: highPriorityTasksList.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (context, index) {
                final TaskModel task = highPriorityTasksList[index];
                return TaskContainer(
                  task: task,
                  onChanged: (bool? value) async {
                    setState(() => task.isDone = value!);
                    final prefs = await SharedPreferences.getInstance();
                    final updatedList = tasksList
                        .map((e) => jsonEncode(e.toJson()))
                        .toList();
                    await prefs.setStringList("tasksList", updatedList);
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
