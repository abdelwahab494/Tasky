import 'package:tasky/core/imports.dart';

class UserEntity extends Equatable {
  final int? isarId;

  final String name;
  final String? quote;
  final String? image;
  final bool isDark;
  final bool isLogged;
  final DateTime lastLoggedDate;

  const UserEntity({
    this.isarId,
    required this.name,
    this.quote,
    this.image,
    this.isDark = true,
    required this.isLogged,
    required this.lastLoggedDate,
  });

  @override
  List<Object?> get props => [
    name,
    quote,
    image,
    isDark,
    isLogged,
    lastLoggedDate,
  ];
}
