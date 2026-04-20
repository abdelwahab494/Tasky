import 'package:tasky/core/imports.dart';

class NoteEntity extends Equatable {
  final int? isarId;
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;

  const NoteEntity({
    this.isarId,
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [isarId, id, title, body, createdAt];
}
