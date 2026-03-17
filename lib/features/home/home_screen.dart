import 'package:tasky/core/imports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSizes.w16,
            AppSizes.h16,
            AppSizes.w16,
            AppSizes.h0,
          ),
          child: CustomScrollView(
            slivers: [
              SliverGap(AppSizes.h30),
              const SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(background: HomeUserWelcome()),
              ),
              SliverGap(AppSizes.h10),
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
                    collapsedHeight: AppSizes.h80,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: EdgeInsets.only(bottom: AppSizes.h8),
                      expandedTitleScale: 1,
                      title: const AchievedContainer(),
                    ),
                  );
                },
              ),
              const HighPriorityContainer(),
              SliverGap(AppSizes.h15),
              const MyTasksActionsRow(),
              SliverGap(AppSizes.h8),
              const MyTasksSection(),
            ],
          ),
        ),
      ),
      floatingActionButton:  FloatingButton(title: S.of(context).addNewTask),
    );
  }
}
