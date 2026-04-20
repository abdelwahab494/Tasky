import 'package:tasky/core/imports.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.state});
  final NoteEntity note;
  final NotesLoaded state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.w16,
        vertical: AppSizes.h16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: state.deletingList.contains(note)
            ? Border.all(
                color: Theme.of(context).colorScheme.error,
                width: AppSizes.w3,
              )
            : Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: AppSizes.w1,
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (note.title != "" && note.title.isNotEmpty)
            Text(
              note.title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.sp17,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          const Gap(8),
          Text(
            note.body,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(AppSizes.h5),
          const Divider(),
          FittedBox(
            child: Row(
              spacing: AppSizes.w5,
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: AppSizes.r12,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  note.createdAt.formatDate(
                    formatType: FormatDateEnum.dateTime,
                  ),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Gap(AppSizes.h5),
        ],
      ),
    );
  }
}
