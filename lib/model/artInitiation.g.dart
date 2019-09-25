// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artInitiation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtInitiation _$ArtInitiationFromJson(Map<String, dynamic> json) {
  return ArtInitiation(
    json['personId'] as String,
    json['line'] as String,
    json['artRegimenId'] as String,
    json['artReasonId'] as String,
  );
}

Map<String, dynamic> _$ArtInitiationToJson(ArtInitiation instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'line': instance.line,
      'artRegimenId': instance.artRegimenId,
      'artReasonId': instance.artReasonId,
    };
