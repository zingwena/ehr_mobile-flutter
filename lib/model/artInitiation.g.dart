// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artInitiation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtInitiation _$ArtInitiationFromJson(Map<String, dynamic> json) {
  return ArtInitiation(
    json['artId'] as String,
    json['regimenType'] as String,
    json['reason'] as String,
    json['regimen'] as String,

  );
}

Map<String, dynamic> _$ArtInitiationToJson(ArtInitiation instance) =>
    <String, dynamic>{
      'artId': instance.artId,
      'regimenType': instance.regimenType,
      'reason': instance.reason,
      'regimen': instance.regimen
    };
