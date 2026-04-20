import 'package:tasky/core/imports.dart';

class SliverAppbar extends StatefulWidget {
  const SliverAppbar({super.key});

  @override
  State<SliverAppbar> createState() => _SliverAppbarState();
}

class _SliverAppbarState extends State<SliverAppbar> with FormHelperMixin {
  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NotesLoaded) {
          if (!state.isSearching) firstC.clear();
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
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: AppSizes.sp40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (state.isDeleting)
                      CloseButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          context.read<NotesBloc>().add(
                            ResetDeletingRequested(),
                          );
                        },
                      ),
                  ],
                ),
              ),
              title: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w16,
                  vertical: AppSizes.h14,
                ),
                child: TextFormField(
                  controller: firstC,
                  cursorHeight: 20,
                  cursorErrorColor: Theme.of(context).colorScheme.error,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium!.copyWith(fontSize: AppSizes.sp16),
                  cursorColor: Theme.of(context).primaryColor,
                  onChanged: (value) => context.read<NotesBloc>().add(
                    SearchNotesRequested(value),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: AppSizes.w12),
                      child: const Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    suffixIcon: state.isSearching
                        ? CloseButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              context.read<NotesBloc>().add(
                                ResetSearchRequested(),
                              );
                            },
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
        }
        return const SliverToBoxAdapter();
      },
    );
  }
}
