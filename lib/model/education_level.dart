import 'package:json_annotation/json_annotation.dart';
import 'base_code.dart';

part 'education_level.g.dart';

@JsonSerializable()
class EducationLevel extends BaseCode {
  EducationLevel(int id, String name, String code) {
    this.id = id;
    this.name = name;
    this.code = code;
  }

  factory EducationLevel.fromJson(Map<String, dynamic> json) =>
      _$EducationLevelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationLevelToJson(this);
}
