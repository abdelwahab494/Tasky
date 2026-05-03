import 'package:tasky/core/imports.dart';

class Dialogs {
  static Future<bool?> showDeletAlertDialog({
    required BuildContext context,
    required String title,
    required String contentText,
    required String action,
  }) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          titleTextStyle: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontSize: AppSizes.sp24),
          content: Text(contentText),
          contentTextStyle: Theme.of(context).textTheme.titleSmall,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.sp16,
                ),
              ),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.sp16,
                ),
              ),
              child: Text(action),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          contentPadding: EdgeInsetsGeometry.fromLTRB(
            AppSizes.w25,
            AppSizes.h12,
            AppSizes.w25,
            AppSizes.h12,
          ),
          actionsPadding: EdgeInsetsGeometry.fromLTRB(
            AppSizes.w25,
            AppSizes.h0,
            AppSizes.w25,
            AppSizes.h16,
          ),
        );
      },
    );
  }
}
