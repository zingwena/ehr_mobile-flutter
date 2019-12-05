// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientsummarydto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientSummaryDto _$PatientSummaryDtoFromJson(Map<String, dynamic> json) {
  return PatientSummaryDto(
    json['personId'] as String,
    json['temperature'] == null
        ? null
        : ValueDate.fromJson(json['temperature'] as Map<String, dynamic>),
    json['bloodPressure'] == null
        ? null
        : ValueDate.fromJson(json['bloodPressure'] as Map<String, dynamic>),
    json['pulse'] == null
        ? null
        : ValueDate.fromJson(json['pulse'] as Map<String, dynamic>),
    json['respiratoryRate'] == null
        ? null
        : ValueDate.fromJson(json['respiratoryRate'] as Map<String, dynamic>),
    json['height'] == null
        ? null
        : ValueDate.fromJson(json['height'] as Map<String, dynamic>),
    json['weight'] == null
        ? null
        : ValueDate.fromJson(json['weight'] as Map<String, dynamic>),
    json['artDetails'] == null
        ? null
        : ArtDetailsDto.fromJson(json['artDetails'] as Map<String, dynamic>),
    (json['investigations'] as List)
        ?.map((e) => e == null
            ? null
            : InvestigationSummaryDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PatientSummaryDtoToJson(PatientSummaryDto instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'temperature': instance.temperature,
      'bloodPressure': instance.bloodPressure,
      'pulse': instance.pulse,
      'respiratoryRate': instance.respiratoryRate,
      'height': instance.height,
      'weight': instance.weight,
      'artDetails': instance.artDetails,
      'investigations': instance.investigations,
    };
