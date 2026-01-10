import 'package:tasky/core/imports.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return StreamBuilder<bool>(
          stream: controller.buttonStream,
          initialData: true,
          builder: (context, snapshot) {
            final bool show = snapshot.data!;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: show ? 170 : 57,
              decoration: BoxDecoration(
                shape: show ? BoxShape.rectangle : BoxShape.circle,
              ),
              child: FloatingActionButton(
                onPressed: () =>
                    controller.addTaskButtonOnPressed(context: context),
                backgroundColor: DarkColors.primary,
                foregroundColor: DarkColors.text2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(500),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add_rounded,
                      size: 25,
                    ).animate().scale(end: const Offset(1.1, 1.1)),

                    if (show) const Gap(5),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: show ? 90 : 0,
                      child: FittedBox(
                        child: Text(
                          "Add New Task",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
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
      },
    );
  }
}
