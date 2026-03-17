import 'package:tasky/core/imports.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.validationMessage,
    this.hintText,
    this.maxLines = 1,
    this.validate = true,
    this.autofocus = false,
    this.enableEditing = true,
  });
  final String title;
  final TextEditingController controller;
  final String validationMessage;
  final String? hintText;
  final bool validate;
  final int maxLines;
  final bool autofocus;
  final bool enableEditing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displayMedium!.copyWith(fontSize: AppSizes.sp16),
        ),
        Gap(AppSizes.h8),
        TextFormField(
          controller: controller,
          cursorHeight: AppSizes.h20,
          cursorErrorColor: Theme.of(context).colorScheme.error,
          enabled: enableEditing,
          validator: (value) {
            if (validate) {
              if (value == null || value.trim().isEmpty) {
                return validationMessage;
              }
            }
            return null;
          },
          autofocus: autofocus,
          style: Theme.of(
            context,
          ).textTheme.displayMedium!.copyWith(fontSize: AppSizes.sp16),
          decoration: InputDecoration(
            hintText: hintText,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: AppSizes.w1half,
              ),
              borderRadius: BorderRadius.circular(AppSizes.r20),
            ),
            errorStyle: GoogleFonts.plusJakartaSans(
              color: Theme.of(context).colorScheme.error,
              fontSize: AppSizes.sp12,
              fontWeight: FontWeight.w600,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: AppSizes.w1half,
              ),
              borderRadius: BorderRadius.circular(AppSizes.r20),
            ),
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
