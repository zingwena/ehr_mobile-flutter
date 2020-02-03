// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lactatingstatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LactatingStatus _$LactatingStatusFromJson(Map<String, dynamic> json) {
  return LactatingStatus(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$LactatingStatusToJson(LactatingStatus instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
