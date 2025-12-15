import 'package:flutter/cupertino.dart';
import 'package:tasky/core/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasksList = [];
  List<TaskModel> completedTasksList = [];
  List<TaskModel> highPriorityTasksList = [];
  List<TaskModel> tasksListBeforeDeleting = [];
  bool show = true;
  bool showMessage = false;
  bool sortList = false;

  @override
  void initState() {
    super.initState();
    _loadData();
    Future.delayed(Duration(milliseconds: 2600), () {
      setState(() {
        show = false;
      });
    });
    Future.delayed(Duration(seconds: 1), () {
      if (tasksList.isEmpty) {
        setState(() => showMessage = true);
      }
    });
  }

  Future<void> _loadData() async {
    List<TaskModel> fetchedTasksList = await PrefHelper.getTasksList();

    if (mounted) {
      setState(() {
        tasksList = sortList
            ? fetchedTasksList.reversed.toList()
            : fetchedTasksList;
        completedTasksList = tasksList
            .where((element) => element.isDone == true)
            .toList();
        highPriorityTasksList = fetchedTasksList.reversed
            .where((element) => element.isHighPriority == true)
            .toList();
        showMessage = tasksList.isEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: CustomScrollView(
            slivers: [
              const SliverGap(40),
              SliverToBoxAdapter(child: HomeUserWelcome()),
              const SliverGap(16),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EncourageSentence(),
                    Gap(16),
                    AchievedContainer(
                      completed: completedTasksList.length,
                      total: tasksList.length,
                    ),
                    Gap(8),
                    highPriorityTasksList.isNotEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                          bottom: 8,
                                        ),
                                        child: Text(
                                          "High Priority Tasks",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(
                                              context,
                                            ).primaryColor,
                                          ),
                                        ),
                                      ),
                                      ...List.generate(
                                        highPriorityTasksList.length <= 4
                                            ? highPriorityTasksList.length
                                            : 4,
                                        (index) {
                                          final TaskModel priorityTask =
                                              highPriorityTasksList[index];
                                          return Row(
                                            spacing: 8,
                                            children: [
                                              SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: CustomCheckBox(
                                                  value: priorityTask.isDone,
                                                  onChanged: (value) async {
                                                    setState(() {
                                                      priorityTask.isDone =
                                                          value!;
                                                      completedTasksList =
                                                          tasksList
                                                              .where(
                                                                (element) =>
                                                                    element
                                                                        .isDone ==
                                                                    true,
                                                              )
                                                              .toList();
                                                    });
                                                    await PrefHelper.updateTasksList(
                                                      tasksList,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  priorityTask.taskName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                if (highPriorityTasksList.length > 2)
                                  GestureDetector(
                                    onTap: () async {
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (c) => HighPriorityScreen(),
                                        ),
                                      );
                                      _loadData();
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: DarkColors.text4,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.arrow_outward_outlined,
                                        size: 23,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              const SliverGap(15),
              SliverToBoxAdapter(
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
                    if (!showMessage)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() => sortList = !sortList);
                              _loadData();
                            },
                            icon: Icon(
                              sortList
                                  ? CupertinoIcons.sort_down
                                  : CupertinoIcons.sort_up,
                            ),
                            tooltip: sortList ? "Sort Down" : "Sort Up",
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
                              if (tasksList.isNotEmpty) {
                                final bool?
                                result = await Dialogs.showDeletAlertDialog(
                                  context: context,
                                  title: "Delete All Tasks",
                                  contentText:
                                      "All tasks will be deleted permanently.",
                                  action: "Delete",
                                );
                                if (result == true) {
                                  await PrefHelper.clearTasksList();
                                  _loadData();
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
              ),
              const SliverGap(8),
              showMessage
                  ? SliverToBoxAdapter(
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Center(
                          child: SizedBox(
                            width: 110,
                            height: 170,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FittedBox(
                                  child: Text(
                                    "No Tasks Yet",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 500),
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    "Start your first one",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontSize: 500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: EdgeInsets.only(bottom: 80),
                      sliver: SliverList.separated(
                        itemCount: tasksList.length,
                        itemBuilder: (context, index) {
                          final TaskModel task = tasksList[index];
                          return TaskContainer(
                            task: task,
                            onChanged: (bool? value) async {
                              setState(() {
                                task.isDone = value!;
                                completedTasksList = tasksList
                                    .where((element) => element.isDone == true)
                                    .toList();
                              });
                              await PrefHelper.updateTasksList(tasksList);
                            },
                            onDelete: () async {
                              setState(
                                () => tasksListBeforeDeleting = List.from(
                                  tasksList,
                                ),
                              );
                              tasksList.removeWhere((e) => e == task);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Task Deleted Successfully.",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
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
                              final bool? result =
                                  await Dialogs.showEditTaskSheet(
                                    context: context,
                                    task: task,
                                  );
                              if (result == true) _loadData();
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
                        separatorBuilder: (BuildContext context, int index) =>
                            Gap(8),
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: show ? 170 : 57,
        decoration: BoxDecoration(
          shape: show ? BoxShape.rectangle : BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => AddTaskScreen()),
            );
            if (result != null && result) {
              _loadData();
            }
          },
          backgroundColor: DarkColors.primary,
          foregroundColor: DarkColors.text2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(500),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_rounded, size: 25)
                  .animate(delay: Duration(seconds: 2))
                  .scale(end: Offset(1.1, 1.1)),
              if (show) Gap(5),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: show ? 90 : 0,
                child: FittedBox(
                  child: Text(
                    "Add New Task",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ).animate(delay: Duration(seconds: 2)).fadeOut(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
