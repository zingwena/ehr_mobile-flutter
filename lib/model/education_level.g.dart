// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationLevel _$EducationLevelFromJson(Map<String, dynamic> json) {
  return EducationLevel(
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$EducationLevelToJson(EducationLevel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
