import 'package:tasky/core/imports.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.icon,
  });
  final Function() onPressed;
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.w16),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        // style: Theme.of(context).elevatedButtonTheme.style,
        label: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: AppSizes.sp14,
          ),
        ),
        icon: icon != null ? Icon(icon) : null,
      ),
    );
  }
}
