import 'package:tasky/core/imports.dart';

class HomeUserWelcome extends StatefulWidget {
  const HomeUserWelcome({super.key});

  @override
  State<HomeUserWelcome> createState() => _HomeUserWelcomeState();
}

class _HomeUserWelcomeState extends State<HomeUserWelcome> {
  late String name;
  late String quote;
  String? image;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Gap(1),
        AvatarGlow(
          glowRadiusFactor: 0.2,
          glowColor: Theme.of(context).primaryColor,
          startDelay: Duration(seconds: 1),
          child: CircleAvatar(
            radius: 23,
            backgroundImage: image == null
                ? AssetImage("assets/images/profile.png")
                : FileImage(File(image!)),
            backgroundColor: Colors.transparent,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isLoading ? "Hello," : "Hello, $name",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(letterSpacing: 0.5),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                isLoading ? "One task at a time. One step closer." : quote,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(letterSpacing: 0.25),
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
    );
  }
}
