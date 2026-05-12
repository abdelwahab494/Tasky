import 'package:tasky/core/imports.dart';

part 'settings_model.g.dart';

@Collection()
class SettingsModel {
  Id isarId = Isar.autoIncrement;

  @enumerated
  late ThemeMode themeMode;

  SettingsModel();

  factory SettingsModel.fromEntity(SettingsEntity entity) {
    return SettingsModel()
      ..isarId = entity.isarId ?? Isar.autoIncrement
      ..themeMode = entity.themeMode;
  }

  SettingsEntity toEntity() {
    return SettingsEntity(isarId: isarId, themeMode: themeMode);
  }

  SettingsModel copyWith({Id? isarId, ThemeMode? themeMode}) {
    return SettingsModel()
      ..isarId = isarId ?? Isar.autoIncrement
      ..themeMode = themeMode ?? this.themeMode;
  }
}
