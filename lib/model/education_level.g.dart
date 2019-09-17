// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationLevel _$EducationLevelFromJson(Map<String, dynamic> json) {
  return EducationLevel(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$EducationLevelToJson(EducationLevel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
