import 'package:tasky/core/imports.dart';

enum ImageActionsEnum {
  camera(icon: Icons.camera_alt_outlined, title: "Open Camera"),
  gallery(icon: Icons.photo_library_outlined, title: "Choose From Gallery"),
  delete(icon: Icons.delete, title: "Remove Image");

  final IconData icon;
  final String title;

  const ImageActionsEnum({required this.icon, required this.title});
}
