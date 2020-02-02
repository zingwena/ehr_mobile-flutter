// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followupstatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowUpStatus _$FollowUpStatusFromJson(Map<String, dynamic> json) {
  return FollowUpStatus(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$FollowUpStatusToJson(FollowUpStatus instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
};
