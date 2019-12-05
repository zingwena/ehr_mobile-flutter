// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artdetailsdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtDetailsDto _$ArtDetailsDtoFromJson(Map<String, dynamic> json) {
  return ArtDetailsDto(
    json['dateRegistered'] == null ? null : DateTime.parse(json['date'] as String),
    json['artNumber'] as String,
    json['whoStage'] as String,
    json['arvRegimen'] as String,


  );
}

Map<String, dynamic> _$ArtDetailsToJson(ArtDetailsDto instance) => <String, dynamic>{
  'dateRegistered': instance.dateRegistered,
  'artNumber': instance.artNumber,
  'whoStage': instance.whoStage,
  'arvRegimen': instance.arvRegimen,

};
