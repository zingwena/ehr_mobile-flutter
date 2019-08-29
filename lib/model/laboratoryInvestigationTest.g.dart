// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laboratoryInvestigationTest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaboratoryInvestigationTest _$LaboratoryInvestigationTestFromJson(
    Map<String, dynamic> json) {
  return LaboratoryInvestigationTest(
    json['id'] as int,
    json['startdate'] == null
        ? null
        : DateTime.parse(json['startdate'] as String),
    json['starttime'] == null
        ? null
        : DateTime.parse(json['starttime'] as String),
    json['readingdate'] == null
        ? null
        : DateTime.parse(json['readingdate'] as String),
    json['readingtime'] == null
        ? null
        : DateTime.parse(json['readingtime'] as String),
    json['result'] == null
        ? null
        : Result.fromJson(json['result'] as Map<String, dynamic>),
    json['visitId'] as String,
  )..laboratoryInvestigationId = json['laboratoryInvestigationId'] as String;
}

Map<String, dynamic> _$LaboratoryInvestigationTestToJson(
        LaboratoryInvestigationTest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'laboratoryInvestigationId': instance.laboratoryInvestigationId,
      'startdate': instance.startdate?.toIso8601String(),
      'starttime': instance.starttime?.toIso8601String(),
      'readingdate': instance.readingdate?.toIso8601String(),
      'readingtime': instance.readingtime?.toIso8601String(),
      'result': instance.result,
      'visitId': instance.visitId,
    };
