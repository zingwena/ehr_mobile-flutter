// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followupoutcome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowUpOutcome _$FollowUpOutcomeFromJson(Map<String, dynamic> json) {
  return FollowUpOutcome(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$FollowUpOutcomeToJson(FollowUpOutcome instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
