// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artdetailsdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtDetailsDto _$ArtDetailsDtoFromJson(Map<String, dynamic> json) {
  return ArtDetailsDto(
    const CustomDateTimeConverter().fromJson(json['dateRegistered'] as String),
    json['artNumber'] as String,
    json['whoStage'] as String,
    json['arvRegimen'] as String,
  );
}

Map<String, dynamic> _$ArtDetailsDtoToJson(ArtDetailsDto instance) =>
    <String, dynamic>{
      'dateRegistered': const CustomDateTimeConverter().toJson(instance.dateRegistered),
      'artNumber': instance.artNumber,
      'whoStage': instance.whoStage,
      'arvRegimen': instance.arvRegimen,
    };
