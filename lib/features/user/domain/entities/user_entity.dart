import 'package:tasky/core/imports.dart';

class UserEntity extends Equatable {
  final int? isarId;

  final String name;
  final String? quote;
  final String? image;
  final bool isDark;
  final bool isLogged;
  final DateTime lastLoggedDate;

  static const _sentinel = Object();

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

  UserEntity copyWith({
    int? isarId,
    String? name,
    String? quote,
    Object? image = _sentinel,
    bool? isDark,
    bool? isLogged,
    DateTime? lastLoggedDate,
  }) {
    return UserEntity(
      isarId: isarId ?? this.isarId,
      name: name ?? this.name,
      quote: quote ?? this.quote,
      image: image == _sentinel ? this.image : image as String?,
      isDark: isDark ?? this.isDark,
      isLogged: isLogged ?? this.isLogged,
      lastLoggedDate: lastLoggedDate ?? this.lastLoggedDate,
    );
  }
}
