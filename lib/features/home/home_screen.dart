import 'package:tasky/core/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: CustomScrollView(
            slivers: [
              SliverGap(30),
              SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(background: HomeUserWelcome()),
              ),
              // SliverGap(16),
              // EncourageSentence(),
              SliverGap(16),
              SliverAppBar(
                pinned: true,
                expandedHeight: 160,
                collapsedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  expandedTitleScale: 1,
                  background: EncourageSentence(),
                  title: AchievedContainer(),
                ),
              ),
              HighPriorityContainer(),
              SliverGap(15),
              MyTasksActionsRow(),
              SliverGap(8),
              MyTasksSection(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButton(title: "Add New Task"),
    );
  }
}
