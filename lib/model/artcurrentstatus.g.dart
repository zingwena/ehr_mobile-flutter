// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artcurrentstatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtCurrentStatus _$ArtCurrentStatusFromJson(Map<String, dynamic> json) {
  return ArtCurrentStatus(
    json['id'] as String,
    const CustomDateTimeConverter()
        .fromJson(json['date'] as String),
    json['artId'] as String,
    json['state'] as String,
    json['regimen'] == null
        ? null
        : NameCode.fromJson(json['regimen'] as Map<String, dynamic>),
    json['reason'] == null
        ? null
        : NameCode.fromJson(json['reason'] as Map<String, dynamic>),
    json['regimenType'] as String,
    json['adverseEventStatus'] == null
        ? null
        : NameCode.fromJson(json['adverseEventStatus'] as Map<String, dynamic>),

  );
}

Map<String, dynamic> _$ArtCurrentStatusToJson(
    ArtCurrentStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artId': instance.artId,
      'reason': instance.reason,
      'date': instance.date,
      'regimen': instance.regimen,
      'reason': instance.reason,
      'regimenType': instance.regimenType,
      'adverseEventStatus': instance.adverseEventStatus,
    };
