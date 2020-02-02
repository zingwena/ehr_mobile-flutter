// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iptreason.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IptReason _$IptReasonFromJson(Map<String, dynamic> json) {
  return IptReason(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$IptReasonToJson(IptReason instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
};
