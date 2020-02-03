// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'namecode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NameCode _$NameCodeFromJson(Map<String, dynamic> json) {
  return NameCode(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$NameCodeToJson(NameCode instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
