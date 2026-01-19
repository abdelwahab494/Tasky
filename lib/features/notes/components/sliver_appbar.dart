import 'package:tasky/core/imports.dart';

class SliverAppbar extends StatelessWidget {
  const SliverAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesController>(
      builder:
          (BuildContext context, NotesController controller, Widget? child) {
            return SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 150,
              collapsedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                titlePadding: const EdgeInsets.only(top: 15),
                background: Padding(
                  padding: const EdgeInsets.only(bottom: 25, left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Notes",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (controller.isDeleting)
                        CloseButton(onPressed: controller.resetNotesDeleting),
                    ],
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: TextFormField(
                    controller: controller.searchC,
                    cursorHeight: 20,
                    cursorErrorColor: Theme.of(context).colorScheme.error,
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium!.copyWith(fontSize: 16),
                    cursorColor: Theme.of(context).primaryColor,
                    onChanged: (value) => controller.searchFunction(value),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(Icons.search_rounded, color: Colors.grey),
                      ),
                      suffixIcon: controller.isSearching
                          ? CloseButton(
                              onPressed: () => controller.reset(),
                              color: Colors.grey,
                            )
                          : const SizedBox.shrink(),
                      hintText: "Search",
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
            );
          },
    );
  }
}
