// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artdetailsdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtDetailsDto _$ArtDetailsDtoFromJson(Map<String, dynamic> json) {
  return ArtDetailsDto(
    json['dateRegistered'] == null
        ? null
        : DateTime.parse(json['dateRegistered'] as String),
    json['artNumber'] as String,
    json['whoStage'] as String,
    json['arvRegimen'] as String,
  );
}

Map<String, dynamic> _$ArtDetailsDtoToJson(ArtDetailsDto instance) =>
    <String, dynamic>{
      'dateRegistered': instance.dateRegistered?.toIso8601String(),
      'artNumber': instance.artNumber,
      'whoStage': instance.whoStage,
      'arvRegimen': instance.arvRegimen,
    };
