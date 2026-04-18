import 'package:tasky/core/imports.dart';

extension SnackBarExtension on BuildContext {
  void showSuccess(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration ?? const Duration(seconds: 4),
          content: Row(
            spacing: AppSizes.w10,
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppSizes.sp16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(this).primaryColor,
          showCloseIcon: true,
          closeIconColor: Colors.white,
          margin: EdgeInsets.symmetric(
            horizontal: AppSizes.w16,
            vertical: AppSizes.h8,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          elevation: 0,
        ),
      );
  }

  void showError(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration ?? const Duration(seconds: 4),
          content: Row(
            spacing: AppSizes.w10,
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppSizes.sp16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(this).colorScheme.error,
          showCloseIcon: true,
          closeIconColor: Colors.white,
          margin: EdgeInsets.symmetric(
            horizontal: AppSizes.w16,
            vertical: AppSizes.h8,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          elevation: 0,
        ),
      );
  }
}
