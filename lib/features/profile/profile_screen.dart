import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String name;
  late String quote;
  String? image;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    String fetchedName = await PrefHelper.getName() ?? "";
    String fetchedQuote =
        await PrefHelper.getQuote() ?? "One task at a time. One step closer.";
    String? fetchedImage = await PrefHelper.getProfileImage();

    if (mounted) {
      setState(() {
        name = fetchedName;
        quote = fetchedQuote;
        image = fetchedImage;
        isLoading = false;
      });
    }
  }

  Future<void> pickGalleryImage() async {
    try {
      final XFile? pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedImage != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final newFile = await File(
          pickedImage.path,
        ).copy("${appDir.path}/${pickedImage.name}");
        await PrefHelper.saveProfileImage(newFile.path);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Image Changed Successfully.",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          showCloseIcon: true,
          closeIconColor: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Faild to change Image!\nPlease try again.",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red.shade700,
          showCloseIcon: true,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Center(
          child: Column(
            spacing: 30,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AvatarGlow(
                        glowRadiusFactor: 0.2,
                        glowColor: Theme.of(context).primaryColor,
                        startDelay: Duration(seconds: 1),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: image == null
                              ? AssetImage("assets/images/profile.png")
                              : FileImage(File(image!)),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      Positioned(
                        bottom: -12,
                        right: -10,
                        child: IconButton(
                          onPressed: () async {
                            final ImageActionsEnum? result =
                                await Dialogs.showImageSourceDialog(
                                  context: context,
                                );
                            switch (result) {
                              case ImageActionsEnum.gallery:
                                await pickGalleryImage();
                                loadData();
                                break;

                              case ImageActionsEnum.camera:
                                break;

                              case ImageActionsEnum.delete:
                                break;

                              default:
                                break;
                            }
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
                            iconSize: 20,
                          ),
                          icon: Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    ],
                  ),
                  Gap(16),
                  Skeletonizer(
                    enabled: isLoading,
                    containersColor: ThemeController.isDark()
                        ? null
                        : LightColors.text4,
                    child: Column(
                      children: [
                        Text(
                          isLoading ? "Abdelwahab Mo." : name,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(fontSize: 20),
                        ),
                        Gap(4),
                        Text(
                          isLoading
                              ? "One task at a time. One step closer."
                              : quote,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ],
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
                    Gap(16),
                    GestureDetector(
                      onTap: () async {
                        final bool? result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UserDetailsScreen(),
                          ),
                        );
                        if (result == true) {
                          loadData();
                        }
                      },
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
                    Gap(10),
                    Divider(),
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
                    Divider(),
                    Gap(10),
                    GestureDetector(
                      onTap: () async {
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
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (c) => WelcomeScreen()),
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
