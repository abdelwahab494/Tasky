import 'package:tasky/core/imports.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    TodoScreen(),
    CompletedScreen(),
    ProfileScreen(),
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
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 8),
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
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 8),
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
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 8),
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
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 8),
                child: SvgPicture.asset(
                  "assets/icons/profile.svg",
                  colorFilter: ColorFilter.mode(
                    currentIndex == 3
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
