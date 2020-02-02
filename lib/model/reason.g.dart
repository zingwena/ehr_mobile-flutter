// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reason.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reason _$ReasonFromJson(Map<String, dynamic> json) {
  return Reason(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$ReasonToJson(Reason instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
};
