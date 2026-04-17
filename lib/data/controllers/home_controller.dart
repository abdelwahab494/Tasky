import 'package:tasky/core/imports.dart';

class HomeController extends ChangeNotifier {
  List<TasksModel> _tasksList = [];
  List<TasksModel> _toDoTasksList = [];
  List<TasksModel> _completedTasksList = [];
  List<TasksModel> _highPriorityTasksList = [];
  List<TasksModel> _tasksListBeforeDeleting = [];
  bool _sortList = false;
  bool _isLoading = false;
  EncourageEnum _encourageStatus = EncourageEnum.started;
  int _percentage() =>
      ((_tasksList.isEmpty
                  ? 0.0
                  : (_completedTasksList.length / _tasksList.length).clamp(
                      0.0,
                      1.0,
                    )) *
              100)
          .round();
  String _tasks = '';

  final TextEditingController _taskNameC = TextEditingController();
  final TextEditingController _taskDescC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHighPriority = false;

  List<TasksModel> get tasksList => _tasksList;
  List<TasksModel> get toDoTasksList => _toDoTasksList;
  List<TasksModel> get completedTasksList => _completedTasksList;
  List<TasksModel> get highPriorityTasksList => _highPriorityTasksList;
  List<TasksModel> get tasksListBeforeDeleting => _tasksListBeforeDeleting;
  bool get sortList => _sortList;
  bool get isLoading => _isLoading;
  int get percentage => _percentage();
  EncourageEnum get encourageStatus => _encourageStatus;
  Stream<bool> get buttonStream => _buttonState();

  TextEditingController get taskNameC => _taskNameC;
  TextEditingController get taskDescC => _taskDescC;
  GlobalKey<FormState> get formKey => _formKey;
  bool get isHighPriority => _isHighPriority;

  set isHighPriority(bool value) {
    _isHighPriority = value;
    notifyListeners();
  }

  set tasksListBeforeDeleting(List<TasksModel> list) {
    _tasksListBeforeDeleting = list;
    notifyListeners();
  }

  @override
  void dispose() {
    _taskNameC.dispose();
    _taskDescC.dispose();
    super.dispose();
  }

  Future<void> init() async {
    await loadData();
  }

  Future<void> loadData() async {
    // if (_completedTasksList.isNotEmpty && _toDoTasksList.isNotEmpty) return;

    _isLoading = true;
    notifyListeners();
    final List<TasksModel> fetchedTasksList = await PrefHelper.getTasksList();
    updateLists(fetchedTasksList);
    await WidgetHelper.updateAndroidWidget(_tasks);
  }

  void updateLists(List<TasksModel> list) {
    _tasksList = sortList ? list.reversed.toList() : list;
    _toDoTasksList = tasksList
        .where((element) => element.isDone == false)
        .toList();
    _completedTasksList = tasksList
        .where((element) => element.isDone == true)
        .toList();
    _highPriorityTasksList = list.reversed
        .where((element) => element.isHighPriority == true)
        .toList();
    _isLoading = false;
    _encourageStatus = _encourageConditions();
    _tasks = _toDoTasksList.map((e) => e.taskName).join(",");
    notifyListeners();
  }

  Future<void> onChanged({
    required bool? value,
    required TasksModel task,
  }) async {
    task.isDone = value!;
    await PrefHelper.updateTasksList(_tasksList);
    updateLists(_tasksList);
    await WidgetHelper.updateAndroidWidget(_tasks);
  }

  Future<void> onDelete({
    required BuildContext context,
    required TasksModel task,
    required Function(BuildContext context, HomeController controller)
    showDeletingMessage,
  }) async {
    _tasksListBeforeDeleting = List.from(_tasksList);
    _tasksList.removeWhere((e) => e == task);
    showDeletingMessage(context, this);
    await PrefHelper.updateTasksList(_tasksList);
    updateLists(_tasksList);
    await WidgetHelper.updateAndroidWidget(_tasks);
  }

  Future<void> onEdit({
    required BuildContext context,
    required TasksModel task,
  }) async {
    await Dialogs.showEditTaskSheet(context: context, task: task.toEntity());
    loadData();
  }

  Future<void> togglePriority({required TasksModel task}) async {
    task.isHighPriority = !task.isHighPriority;
    // notifyListeners();
    await PrefHelper.updateTasksList(tasksList);
    updateLists(_tasksList);
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
      MaterialPageRoute(builder: (c) => const AddTaskScreen()),
    );
    if (result != null && result) {
      await loadData();
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
    } else if (_completedTasksList.isNotEmpty &&
        _completedTasksList.length < _tasksList.length) {
      return EncourageEnum.isGoing;
    } else if (_tasksList.isEmpty) {
      return EncourageEnum.begin;
    } else {
      return EncourageEnum.started;
    }
  }

  Future<void> addNewTask(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final String taskTitle = _taskNameC.text;
    final navigator = Navigator.of(context);
    _tasks = _tasks.isEmpty ? taskTitle : '$_tasks,$taskTitle';
    await PrefHelper.addNewTask(
      TasksModel(
        taskName: _taskNameC.text.trim(),
        taskDesc: _taskDescC.text.trim(),
        isHighPriority: _isHighPriority,
      ),
    );
    await WidgetHelper.updateAndroidWidget(_tasks);
    navigator.pop(true);
  }

  Future<void> logOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    final bool? result = await Dialogs.showDeletAlertDialog(
      context: context,
      title: "Log Out",
      contentText: "All data will be permanently deleted.",
      action: "Log out",
    );
    if (result == true) {
      await PrefHelper.clearName();
      await PrefHelper.clearQuote();
      await PrefHelper.clearTasksList();
      await PrefHelper.clearProfileImage();
      await PrefHelper.clearNotesList();
      await WidgetHelper.updateAndroidWidget("");
      _tasksList.clear();
      updateLists(_tasksList);
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => const WelcomeScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }
}
