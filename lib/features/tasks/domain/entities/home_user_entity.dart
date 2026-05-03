import 'package:tasky/core/imports.dart';

class HomeUserEntity extends Equatable{
  final String name;
  final String? imagePath;
  final String? quote;

  const HomeUserEntity({required this.name, required this.imagePath,this.quote});
  
  @override
  List<Object?> get props => [name, imagePath, quote];
}
