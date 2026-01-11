import 'package:tasky/core/imports.dart';

class HomeController extends ChangeNotifier {
  List<TaskModel> _tasksList = [];
  List<TaskModel> _toDoTasksList = [];
  List<TaskModel> _completedTasksList = [];
  List<TaskModel> _highPriorityTasksList = [];
  List<TaskModel> _tasksListBeforeDeleting = [];
  bool _sortList = false;
  bool _isLoading = true;
  int _percentage() =>
      ((_tasksList.isEmpty
                  ? 0.0
                  : (_completedTasksList.length / _tasksList.length).clamp(
                      0.0,
                      1.0,
                    )) *
              100)
          .round();
  late final Stream<bool> _buttonStream = _buttonState();
  EncourageEnum _encourageStatus = EncourageEnum.started;

  List<TaskModel> get tasksList => _tasksList;
  List<TaskModel> get toDoTasksList => _toDoTasksList;
  List<TaskModel> get completedTasksList => _completedTasksList;
  List<TaskModel> get highPriorityTasksList => _highPriorityTasksList;
  List<TaskModel> get tasksListBeforeDeleting => _tasksListBeforeDeleting;
  bool get sortList => _sortList;
  bool get isLoading => _isLoading;
  int get percentage => _percentage();
  Stream<bool> get buttonStream => _buttonStream;
  EncourageEnum get encourageStatus => _encourageStatus;

  set tasksListBeforeDeleting(List<TaskModel> list) {
    _tasksListBeforeDeleting = list;
    notifyListeners();
  }

  Future<void> init() async {
    await loadData();
  }

  Future<void> loadData() async {
    final List<TaskModel> fetchedTasksList = await PrefHelper.getTasksList();

    _tasksList = sortList
        ? fetchedTasksList.reversed.toList()
        : fetchedTasksList;
    _toDoTasksList = tasksList
        .where((element) => element.isDone == false)
        .toList();
    _completedTasksList = tasksList
        .where((element) => element.isDone == true)
        .toList();
    _highPriorityTasksList = fetchedTasksList.reversed
        .where((element) => element.isHighPriority == true)
        .toList();
    _isLoading = false;
    _encourageStatus = _encourageConditions();
    notifyListeners();
  }

  Future<void> onChanged({
    required bool? value,
    required TaskModel task,
  }) async {
    task.isDone = value!;
    _completedTasksList = _tasksList
        .where((element) => element.isDone == true)
        .toList();
    await PrefHelper.updateTasksList(tasksList);
    loadData();
    notifyListeners();
  }

  Future<void> onDelete({
    required BuildContext context,
    required TaskModel task,
    required Function(BuildContext context, HomeController controller)
    showDeletingMessage,
  }) async {
    _tasksListBeforeDeleting = List.from(_tasksList);
    _tasksList.removeWhere((e) => e == task);
    showDeletingMessage(context, this);
    await PrefHelper.updateTasksList(_tasksList);
    loadData();
    notifyListeners();
  }

  Future<void> onEdit({
    required BuildContext context,
    required TaskModel task,
  }) async {
    final bool? result = await Dialogs.showEditTaskSheet(
      context: context,
      task: task,
    );
    if (result == true) loadData();
  }

  Future<void> togglePriority({required TaskModel task}) async {
    task.isHighPriority = !task.isHighPriority;
    notifyListeners();
    await PrefHelper.updateTasksList(tasksList);
    loadData();
  }

  Future<void> toggleSortingList() async {
    _sortList = !_sortList;
    _tasksList = _tasksList.reversed.toList();
    notifyListeners();
    await PrefHelper.updateTasksList(_tasksList);
  }

  Future<void> addTaskButtonOnPressed({required BuildContext context}) async {
    final bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => AddTaskScreen()),
    );
    if (result != null && result) {
      loadData();
    }
  }

  Stream<bool> _buttonState() async* {
    yield true;
    await Future.delayed(const Duration(seconds: 2));
    yield false;
  }

  EncourageEnum _encourageConditions() {
    if (_completedTasksList.isNotEmpty &&
        _completedTasksList.length == _tasksList.length) {
      return EncourageEnum.isDone;
    } else if (completedTasksList.isNotEmpty &&
        completedTasksList.length < tasksList.length) {
      return EncourageEnum.isGoing;
    } else {
      return EncourageEnum.started;
    }
  }
}
