// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iptstatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IptStatus _$IptStatusFromJson(Map<String, dynamic> json) {
  return IptStatus(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$IptStatusToJson(IptStatus instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
