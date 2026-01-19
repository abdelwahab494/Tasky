import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: CustomScrollView(
          slivers: [
            const SliverCustomAppbar(title: "Profile"),
            Consumer<UserDetailsController>(
              builder: (context, controller, child) {
                return SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller.image != null) {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Image.file(File(controller.image!)),
                                  ),
                                );
                              }
                            },
                            child: AvatarGlow(
                              glowRadiusFactor: 0.2,
                              glowColor: Theme.of(context).primaryColor,
                              startDelay: const Duration(seconds: 1),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: controller.image == null
                                    ? const AssetImage(
                                        "assets/images/profile.png",
                                      )
                                    : FileImage(File(controller.image!)),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -12,
                            right: -10,
                            child: Selector<ThemeController, bool>(
                              selector: (context, controller) =>
                                  controller.isDark,
                              builder: (context, value, child) {
                                return IconButton(
                                  onPressed: () =>
                                      controller.selectImageActions(context),
                                  style: IconButton.styleFrom(
                                    backgroundColor: value
                                        ? DarkColors.backGround2
                                        : LightColors.backGround2,
                                    foregroundColor: value
                                        ? DarkColors.text2
                                        : LightColors.text2,
                                    side: value
                                        ? BorderSide.none
                                        : BorderSide(color: LightColors.border),
                                    iconSize: 20,
                                  ),
                                  icon: const Icon(Icons.camera_alt_outlined),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),
                      Selector<ThemeController, bool>(
                        selector: (context, controller) => controller.isDark,
                        builder: (context, value, child) {
                          return Skeletonizer(
                            enabled: controller.isLoading,
                            containersColor: value ? null : LightColors.text4,
                            child: Column(
                              children: [
                                Text(
                                  controller.isLoading
                                      ? "Abdelwahab Mo."
                                      : controller.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 20),
                                ),
                                const Gap(4),
                                Text(
                                  controller.isLoading
                                      ? "One task at a time. One step closer."
                                      : controller.quote,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SliverGap(30),

            SliverFillRemaining(
              hasScrollBody: false,
              child: Consumer<ThemeController>(
                builder: (context, controller, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Profile Info",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(fontSize: 20),
                      ),
                      const Gap(16),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: context.read<UserDetailsController>(),
                              child: const UserDetailsScreen(),
                            ),
                          ),
                        ),
                        child: ProfileRow(
                          svgPicture: "assets/icons/profile.svg",
                          title: "User Details",
                          trailing: Icon(
                            Icons.arrow_forward_rounded,
                            color: controller.isDark
                                ? DarkColors.text2
                                : LightColors.text2,
                          ),
                        ),
                      ),
                      const Gap(10),
                      const Divider(),
                      ProfileRow(
                        svgPicture: "assets/icons/darkmode.svg",
                        title: "Dark Mode",
                        trailing: Switch(
                          value: controller.isDark,
                          onChanged: (value) async {
                            await controller.toggleTheme();
                          },
                        ),
                      ),
                      const Divider(),
                      const Gap(10),
                      GestureDetector(
                        onTap: () =>
                            context.read<HomeController>().logOut(context),
                        child: ProfileRow(
                          svgPicture: "assets/icons/logout.svg",
                          title: "Log Out",
                          trailing: Icon(
                            Icons.arrow_forward_rounded,
                            color: controller.isDark
                                ? DarkColors.text2
                                : LightColors.text2,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
