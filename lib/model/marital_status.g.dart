// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marital_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaritalStatus _$MaritalStatusFromJson(Map<String, dynamic> json) {
  return MaritalStatus(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$MaritalStatusToJson(MaritalStatus instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
