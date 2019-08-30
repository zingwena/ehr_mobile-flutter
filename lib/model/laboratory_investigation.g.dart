// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laboratory_investigation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaboratoryInvestigation _$LaboratoryInvestigationFromJson(
    Map<String, dynamic> json) {
  return LaboratoryInvestigation(
    json['facilityId'] as int,
    const CustomDateTimeConverter().fromJson(json['resultDate'] as String),
  );
}

Map<String, dynamic> _$LaboratoryInvestigationToJson(
        LaboratoryInvestigation instance) =>
    <String, dynamic>{
      'facilityId': instance.facilityId,
      'resultDate': const CustomDateTimeConverter().toJson(instance.resultDate),
    };
