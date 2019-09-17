// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occupation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Occupation _$OccupationFromJson(Map<String, dynamic> json) {
  return Occupation(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$OccupationToJson(Occupation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
