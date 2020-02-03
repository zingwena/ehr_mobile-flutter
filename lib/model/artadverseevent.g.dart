// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artadverseevent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtAdverseEvent _$ArtAdverseEventFromJson(Map<String, dynamic> json) {
  return ArtAdverseEvent(
    json['id'] as String,
    json['statusId'] as String,
    json['code'] as String,
    json['name'] as String,
    json['reason'] == null
        ? null
        : NameCode.fromJson(json['reason'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ArtAdverseEventToJson(ArtAdverseEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'statusId': instance.statusId,
      'code': instance.code,
      'name': instance.name,
      'reason': instance.reason,
    };
