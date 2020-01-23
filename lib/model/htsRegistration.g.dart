// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'htsRegistration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HtsRegistration _$HtsRegistrationFromJson(Map<String, dynamic> json) {
  return HtsRegistration(
    json['personId'] as String,
    json['visitId'] as String,
    json['htsType'] as String,
    const CustomDateTimeConverter().fromJson(json['dateOfHivTest'] as String),
    json['entryPointId'] as String,
    json['laboratoryInvestigationId'] as String,

  );
}

Map<String, dynamic> _$HtsRegistrationToJson(HtsRegistration instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'visitId': instance.visitId,
      'dateOfHivTest':
          const CustomDateTimeConverter().toJson(instance.dateOfHivTest),
      'htsType': instance.htsType,
      'entryPointId': instance.entryPointId,
      'laboratoryInvestigationId': instance.laboratoryInvestigationId
    };
