import 'package:tasky/core/imports.dart';

class SliverAppbar extends StatelessWidget {
  const SliverAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Consumer<NotesController>(
      builder:
          (BuildContext context, NotesController controller, Widget? child) {
            return SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: AppSizes.h150,
              collapsedHeight: AppSizes.h80,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                titlePadding: EdgeInsets.only(top: AppSizes.h15),
                background: Padding(
                  padding: EdgeInsets.only(
                    bottom: AppSizes.h25,
                    left: AppSizes.w16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.notes,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontSize: AppSizes.sp40,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (controller.isDeleting)
                        CloseButton(onPressed: controller.resetNotesDeleting),
                    ],
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.w16,
                    vertical: AppSizes.h14,
                  ),
                  child: TextFormField(
                    controller: controller.searchC,
                    cursorHeight: 20,
                    cursorErrorColor: Theme.of(context).colorScheme.error,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: AppSizes.sp16,
                    ),
                    cursorColor: Theme.of(context).primaryColor,
                    onChanged: (value) => controller.searchFunction(value),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: AppSizes.w12),
                        child: const Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      suffixIcon: controller.isSearching
                          ? CloseButton(
                              onPressed: () => controller.reset(),
                              color: Colors.grey,
                            )
                          : const SizedBox.shrink(),
                      hintText: s.search,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: AppSizes.h14,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
    );
  }
}
