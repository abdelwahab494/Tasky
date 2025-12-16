import 'package:tasky/core/imports.dart';

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    required this.svgPicture,
    required this.title,
    required this.trailing,
  });
  final String svgPicture;
  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          svgPicture,
          colorFilter: ColorFilter.mode(
            ThemeController.isDark() ? DarkColors.text2 : LightColors.text2,
            BlendMode.srcIn,
          ),
        ),
        Gap(16),
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        trailing,
      ],
    );
  }
}
