// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nationality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nationality _$NationalityFromJson(Map<String, dynamic> json) {
  return Nationality(
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$NationalityToJson(Nationality instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
