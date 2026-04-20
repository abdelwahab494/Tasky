import 'package:tasky/core/imports.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _buttonState(),
      initialData: true,
      builder: (context, snapshot) {
        final bool show = snapshot.data!;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: show ? AppSizes.w170 : AppSizes.w57,
          height: AppSizes.w57,
          decoration: BoxDecoration(
            shape: show ? BoxShape.rectangle : BoxShape.circle,
          ),
          child: FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: DarkColors.primary,
            foregroundColor: DarkColors.text2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.r500),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_rounded,
                  size: AppSizes.r25,
                ).animate().scale(end: const Offset(1.1, 1.1)),

                if (show) Gap(AppSizes.w5),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: show ? AppSizes.w90 : AppSizes.w0,
                  child: FittedBox(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: AppSizes.sp15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Stream<bool> _buttonState() async* {
    yield true;
    await Future.delayed(const Duration(seconds: 2));
    yield false;
  }
}
