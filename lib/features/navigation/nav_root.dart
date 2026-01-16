import 'package:tasky/core/imports.dart';

class NavRoot extends StatefulWidget {
  const NavRoot({super.key});

  @override
  State<NavRoot> createState() => _NavRootState();
}

class _NavRootState extends State<NavRoot> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const TodoScreen(),
    const CompletedScreen(),
    const NotesScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                margin: const EdgeInsets.only(bottom: 4, top: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
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
              label: "Home",
              tooltip: "Home",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                margin: const EdgeInsets.only(bottom: 4, top: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
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
              label: "To Do",
              tooltip: "To Do",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                margin: const EdgeInsets.only(bottom: 4, top: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
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
              label: "Completed",
              tooltip: "Completed",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                margin: const EdgeInsets.only(bottom: 4, top: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
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
              label: "Notes",
              tooltip: "Notes",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                margin: const EdgeInsets.only(bottom: 4, top: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
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
              label: "Profile",
              tooltip: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
