import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart' hide ShimmerEffect;

class HomeUserWelcome extends StatelessWidget {
  const HomeUserWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ChangeNotifierProvider(
        create: (_) => UserDetailsController(),
        child: Consumer<UserDetailsController>(
          builder:
              (
                BuildContext context,
                UserDetailsController controller,
                Widget? child,
              ) {
                return Skeletonizer(
                  enabled: controller.isLoading,
                  child: Row(
                    spacing: 10,
                    children: [
                      Gap(1),
                      AvatarGlow(
                        glowRadiusFactor: 0.2,
                        glowColor: Theme.of(context).primaryColor,
                        startDelay: Duration(seconds: 1),
                        child: CircleAvatar(
                          radius: 23,
                          backgroundImage: controller.image == null
                              ? AssetImage("assets/images/profile.png")
                              : FileImage(File(controller.image!)),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.isLoading
                                  ? "Hello,"
                                  : "Hello, ${controller.name}",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(letterSpacing: 0.5),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              controller.isLoading
                                  ? "One task at a time. One step closer."
                                  : controller.quote,
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(letterSpacing: 0.25),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton.filled(
                        onPressed: () async {
                          await ThemeController.toggleTheme();
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: ThemeController.isDark()
                              ? DarkColors.backGround2
                              : LightColors.backGround2,
                          foregroundColor: ThemeController.isDark()
                              ? DarkColors.text2
                              : LightColors.text2,
                          side: ThemeController.isDark()
                              ? BorderSide.none
                              : BorderSide(color: LightColors.border),
                          fixedSize: Size(34, 34),
                        ),
                        icon: SvgPicture.asset(
                          ThemeController.themeNotifier.value == ThemeMode.dark
                              ? "assets/icons/sun.svg"
                              : "assets/icons/moon.svg",
                          width: 22,
                          height: 22,
                        ),
                      ),
                    ],
                  ),
                );
              },
        ),
      ),
    );
  }
}
