// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occupation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Occupation _$OccupationFromJson(Map<String, dynamic> json) {
  return Occupation(
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$OccupationToJson(Occupation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
