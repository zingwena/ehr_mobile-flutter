// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'religion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Religion _$ReligionFromJson(Map<String, dynamic> json) {
  return Religion(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$ReligionToJson(Religion instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
