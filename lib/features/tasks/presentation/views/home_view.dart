import 'package:tasky/core/imports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.w16,
          AppSizes.h34,
          AppSizes.w16,
          AppSizes.h0,
        ),
        child: CustomScrollView(
          slivers: [
            const HomeUserWelcome(),
            SliverGap(AppSizes.h10),
            const EncourageSentence(),
            const AchievedContainer(),
            const HighPriorityContainer(),
            SliverGap(AppSizes.h15),
            const MyTasksActionsRow(),
            SliverGap(AppSizes.h8),
            const MyTasksSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingButton(title: S.of(context).addNewTask),
    );
  }
}
