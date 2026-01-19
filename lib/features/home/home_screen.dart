import 'package:tasky/core/imports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: CustomScrollView(
            slivers: [
              const SliverGap(30),
              const SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(background: HomeUserWelcome()),
              ),
              const SliverGap(10),
              const EncourageSentence(),
              Selector<HomeController, bool>(
                selector: (BuildContext context, HomeController controller) =>
                    controller.tasksList.isEmpty,
                builder: (BuildContext context, bool value, Widget? child) {
                  if (value) {
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  }
                  return SliverAppBar(
                    pinned: !value,
                    collapsedHeight: 80,
                    flexibleSpace: const FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: EdgeInsets.only(bottom: 8),
                      expandedTitleScale: 1,
                      title: AchievedContainer(),
                    ),
                  );
                },
              ),
              const HighPriorityContainer(),
              const SliverGap(15),
              const MyTasksActionsRow(),
              const SliverGap(8),
              const MyTasksSection(),
            ],
          ),
        ),
      ),
      floatingActionButton: const FloatingButton(title: "Add New Task"),
    );
  }
}
