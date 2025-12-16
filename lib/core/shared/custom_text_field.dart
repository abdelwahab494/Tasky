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
  });
  final String title;
  final TextEditingController controller;
  final String validationMessage;
  final String? hintText;
  final bool validate;
  final int maxLines;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displayMedium!.copyWith(fontSize: 16),
        ),
        Gap(8),
        TextFormField(
          controller: controller,
          cursorHeight: 20,
          cursorErrorColor: Theme.of(context).colorScheme.error,
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
          ).textTheme.displayMedium!.copyWith(fontSize: 16),
          decoration: InputDecoration(
            hintText: hintText,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            errorStyle: GoogleFonts.plusJakartaSans(
              color: Theme.of(context).colorScheme.error,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
