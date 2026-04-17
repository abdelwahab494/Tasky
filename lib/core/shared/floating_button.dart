import 'package:tasky/core/imports.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key, required this.title});
  final String title;

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
              width: show ? AppSizes.w170 : AppSizes.w57,
              height: AppSizes.w57,
              decoration: BoxDecoration(
                shape: show ? BoxShape.rectangle : BoxShape.circle,
              ),
              child: FloatingActionButton(
                onPressed: () async {
                  final bool? result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AddTaskPage()),
                  );
                  if (context.mounted && result == true) {
                    context.read<TasksBloc>().add(TasksLoadRequested());
                  }
                },
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
      },
    );
  }
}
