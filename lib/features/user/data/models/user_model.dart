import 'package:tasky/core/imports.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id isarId = Isar.autoIncrement;

  @Index()
  late String name;
  String? quote;
  String? image;
  late bool isDark = true;
  @Index()
  late bool isLogged;
  DateTime lastLoggedDate = DateTime.now();

  final tasks = IsarLinks<TaskModel>();
  final notes = IsarLinks<NoteModel>();

  UserModel();

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel()
      ..isarId = user.isarId ?? Isar.autoIncrement
      ..name = user.name
      ..quote = user.quote
      ..image = user.image
      ..isDark = user.isDark
      ..isLogged = user.isLogged
      ..lastLoggedDate = user.lastLoggedDate;
  }

  UserEntity toEntity() {
    return UserEntity(
      isarId: isarId,
      name: name,
      quote: quote,
      image: image,
      isDark: isDark,
      isLogged: isLogged,
      lastLoggedDate: lastLoggedDate,
    );
  }

  UserModel copyWith({
    Id? isarId,
    String? name,
    String? quote,
    String? image,
    bool? isDark,
    bool? isLogged,
    DateTime? lastLoggedDate,
  }) {
    return UserModel()
      ..isarId = isarId ?? this.isarId
      ..name = name ?? this.name
      ..quote = quote ?? this.quote
      ..image = image ?? this.image
      ..isDark = isDark ?? this.isDark
      ..isLogged = isLogged ?? this.isLogged
      ..lastLoggedDate = lastLoggedDate ?? this.lastLoggedDate;
  }
}
