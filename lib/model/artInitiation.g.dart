// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artInitiation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtInitiation _$ArtInitiationFromJson(Map<String, dynamic> json) {
  return ArtInitiation(
    json['id'] as String,
    json['personId'] as String,
    const CustomDateTimeConverter()
        .fromJson(json['dateOfEnrolmentIntoCare'] as String),
    const CustomDateTimeConverter()
        .fromJson(json['dateInitiatedOnArt'] as String),
    json['clientType'] as String,
    json['clientEligibility'] as String,
    json['line'] as String,
    json['artRegimen'] as String,
    json['reason'] as String,
  );
}

Map<String, dynamic> _$ArtInitiationToJson(ArtInitiation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'personId': instance.personId,
      'dateOfEnrolmentIntoCare': const CustomDateTimeConverter()
          .toJson(instance.dateOfEnrolmentIntoCare),
      'dateInitiatedOnArt':
          const CustomDateTimeConverter().toJson(instance.dateInitiatedOnArt),
      'clientType': instance.clientType,
      'clientEligibility': instance.clientEligibility,
      'line': instance.line,
      'artRegimen': instance.artRegimen,
      'reason': instance.reason,
    };
