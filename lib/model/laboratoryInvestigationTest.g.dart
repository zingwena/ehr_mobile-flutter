// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laboratoryInvestigationTest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaboratoryInvestigationTest _$LaboratoryInvestigationTestFromJson(
    Map<String, dynamic> json) {
  return LaboratoryInvestigationTest(
    json['id'] as String,
    json['laboratoryInvestigationId'] as String,
    json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    json['endTime'] == null ? null : DateTime.parse(json['endTime'] as String),
    json['id'] as String,
    json['visitId'] as String,
    json['testkitId'] as String,

  );
}

Map<String, dynamic> _$LaboratoryInvestigationTestToJson(
        LaboratoryInvestigationTest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'laboratoryInvestigationId': instance.laboratoryInvestigationId,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'result': instance.resultId,
      'visitId': instance.visitId,
      'testkitId': instance.testkitId
    };
