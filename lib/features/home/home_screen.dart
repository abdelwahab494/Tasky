import 'package:tasky/core/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: CustomScrollView(
              slivers: [
                const SliverGap(40),
                const HomeUserWelcome(),
                const SliverGap(16),
                const EncourageSentence(),
                const SliverGap(16),
                const AchievedContainer(),
                const SliverGap(8),
                const HighPriorityContainer(),
                const SliverGap(15),
                const MyTasksActionsRow(),
                const SliverGap(8),
                const MyTasksSection(),
              ],
            ),
          ),
        ),
        floatingActionButton: AddTaskButton(),
      ),
    );
  }
}
