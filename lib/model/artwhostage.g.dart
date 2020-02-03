// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwhostage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtWhoStage _$ArtWhoStageFromJson(Map<String, dynamic> json) {
  return ArtWhoStage(
    json['id'] as String,
    json['artId'] as String,
    const CustomDateTimeConverter()
        .fromJson(json['date'] as String),
    json['followUpStatus'] == null
        ? null
        : NameCode.fromJson(json['followUpStatus'] as Map<String, dynamic>),
    json['stage'] as String,

  );
}


Map<String, dynamic> _$ArtWhoStageToJson(
    ArtWhoStage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artId': instance.artId,
      'date': instance.date,
      'followUpStatus': instance.followUpStatus,
      'stage': instance.stage,

    };
