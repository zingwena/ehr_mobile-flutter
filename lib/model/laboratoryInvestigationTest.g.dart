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
    json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
    json['result'] == null
        ? null
        : Result.fromJson(json['result'] as Map<String, dynamic>),
    json['visitId'] as String,
    json['testkit'] == null
        ? null
        : TestKit.fromJson(json['testkit'] as Map<String, dynamic>),
    json['startTime'] as String,
    json['endTime'] as String,
    json['personId'] as String,
    json['batchIssueId'] as String,
  );
}

Map<String, dynamic> _$LaboratoryInvestigationTestToJson(
        LaboratoryInvestigationTest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'laboratoryInvestigationId': instance.laboratoryInvestigationId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'result': instance.result,
      'visitId': instance.visitId,
      'testkit': instance.testkit,
      'personId': instance.personId,
      'batchIssueId': instance.batchIssueId,
    };
