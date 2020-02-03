// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followupreason.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowUpReason _$FollowUpReasonFromJson(Map<String, dynamic> json) {
  return FollowUpReason(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$FollowUpReasonToJson(FollowUpReason instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
