import 'package:tasky/core/imports.dart';
import 'package:tasky/features/tasks/presentation/pages/todo_page.dart';

class NavRoot extends StatefulWidget {
  const NavRoot({super.key});

  @override
  State<NavRoot> createState() => _NavRootState();
}

class _NavRootState extends State<NavRoot> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const TodoPage(),
    const DonePage(),
    const NotesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
            final S s = S.of(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w18,
                  vertical: AppSizes.h6,
                ),
                margin: EdgeInsets.only(bottom: AppSizes.w4, top: AppSizes.h4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.r500),
                  color: currentIndex == 0
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: SvgPicture.asset(
                  "assets/icons/home.svg",
                  colorFilter: ColorFilter.mode(
                    currentIndex == 0
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.shadow,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: s.home,
              tooltip: s.home,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w18,
                  vertical: AppSizes.h6,
                ),
                margin: EdgeInsets.only(bottom: AppSizes.w4, top: AppSizes.h4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.r500),
                  color: currentIndex == 1
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: SvgPicture.asset(
                  "assets/icons/todo.svg",
                  colorFilter: ColorFilter.mode(
                    currentIndex == 1
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.shadow,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: s.toDo,
              tooltip: s.toDo,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w18,
                  vertical: AppSizes.h6,
                ),
                margin: EdgeInsets.only(bottom: AppSizes.w4, top: AppSizes.h4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.r500),
                  color: currentIndex == 2
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: SvgPicture.asset(
                  "assets/icons/completed.svg",
                  colorFilter: ColorFilter.mode(
                    currentIndex == 2
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.shadow,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: s.completed,
              tooltip: s.completed,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w18,
                  vertical: AppSizes.h6,
                ),
                margin: EdgeInsets.only(bottom: AppSizes.w4, top: AppSizes.h4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.r500),
                  color: currentIndex == 3
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: SvgPicture.asset(
                  "assets/icons/notes.svg",
                  colorFilter: ColorFilter.mode(
                    currentIndex == 3
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.shadow,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: s.notes,
              tooltip: s.notes,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w18,
                  vertical: AppSizes.h6,
                ),
                margin: EdgeInsets.only(bottom: AppSizes.w4, top: AppSizes.h4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.r500),
                  color: currentIndex == 4
                      ? Theme.of(context).primaryColor.withOpacity(0.2)
                      : Colors.transparent,
                ),
                child: SvgPicture.asset(
                  "assets/icons/profile.svg",
                  colorFilter: ColorFilter.mode(
                    currentIndex == 4
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.shadow,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: s.profile,
              tooltip: s.profile,
            ),
          ],
        ),
      ),
    );
  }
}
