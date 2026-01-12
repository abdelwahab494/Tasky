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
      appBar: AppBar(title: const Text("My Profile")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Center(
          child: Column(
            spacing: 30,
            children: [
              Consumer<UserDetailsController>(
                builder: (context, controller, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AvatarGlow(
                            glowRadiusFactor: 0.2,
                            glowColor: Theme.of(context).primaryColor,
                            startDelay: const Duration(seconds: 1),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: controller.image == null
                                  ? const AssetImage("assets/images/profile.png")
                                  : FileImage(File(controller.image!)),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Positioned(
                            bottom: -12,
                            right: -10,
                            child: IconButton(
                              onPressed: () =>
                                  controller.selectImageActions(context),
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
                                iconSize: 20,
                              ),
                              icon: const Icon(Icons.camera_alt_outlined),
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),
                      Skeletonizer(
                        enabled: controller.isLoading,
                        containersColor: ThemeController.isDark()
                            ? null
                            : LightColors.text4,
                        child: Column(
                          children: [
                            Text(
                              controller.isLoading
                                  ? "Abdelwahab Mo."
                                  : controller.name,
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium!.copyWith(fontSize: 20),
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
                      ),
                    ],
                  );
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          color: ThemeController.isDark()
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
                      trailing: ValueListenableBuilder(
                        valueListenable: ThemeController.themeNotifier,
                        builder:
                            (
                              BuildContext context,
                              ThemeMode value,
                              Widget? child,
                            ) {
                              return Switch(
                                value: value == ThemeMode.dark,
                                onChanged: (value) async {
                                  await ThemeController.toggleTheme();
                                },
                              );
                            },
                      ),
                    ),
                    const Divider(),
                    const Gap(10),
                    GestureDetector(
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        final bool? result = await Dialogs.showDeletAlertDialog(
                          context: context,
                          title: "Log Out",
                          contentText: "All data will be deleted permanently.",
                          action: "Log out",
                        );
                        if (result == true) {
                          await PrefHelper.clearName();
                          await PrefHelper.clearQuote();
                          await PrefHelper.clearTasksList();
                          await PrefHelper.clearProfileImage();
                          navigator.pushAndRemoveUntil(
                            MaterialPageRoute(builder: (c) => const WelcomeScreen()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                      child: ProfileRow(
                        svgPicture: "assets/icons/logout.svg",
                        title: "Log Out",
                        trailing: Icon(
                          Icons.arrow_forward_rounded,
                          color: ThemeController.isDark()
                              ? DarkColors.text2
                              : LightColors.text2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
