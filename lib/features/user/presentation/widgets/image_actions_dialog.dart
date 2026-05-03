import 'package:tasky/core/imports.dart';

class ImageActionsDialog extends StatelessWidget {
  const ImageActionsDialog({super.key, this.showDelete = false});
  final bool showDelete;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      children: ImageActionsEnum.values.map((e) {
        if (e == ImageActionsEnum.delete && !showDelete) {
          return const SizedBox.shrink();
        }
        return SimpleDialogOption(
          onPressed: () {
            Navigator.of(context).pop(e);
          },
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.w16,
            vertical: AppSizes.h16,
          ),
          child: Row(
            spacing: AppSizes.w16,
            children: [
              Icon(
                e.icon,
                color: showDelete && e == ImageActionsEnum.delete
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).primaryColor,
                size: AppSizes.r22,
              ),
              Text(
                e.title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: showDelete && e == ImageActionsEnum.delete
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
