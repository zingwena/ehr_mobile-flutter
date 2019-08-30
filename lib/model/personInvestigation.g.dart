// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personInvestigation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonInvestigation _$PersonInvestigationFromJson(Map<String, dynamic> json) {
  return PersonInvestigation(
    json['patientId'] as String,
    json['investigationId'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['resultId'] as String,
  )..personInvestigationId = json['personInvestigationId'] as int;
}

Map<String, dynamic> _$PersonInvestigationToJson(
        PersonInvestigation instance) =>
    <String, dynamic>{
      'personInvestigationId': instance.personInvestigationId,
      'patientId': instance.patientId,
      'investigationId': instance.investigationId,
      'date': instance.date?.toIso8601String(),
      'resultId': instance.resultId,
    };
