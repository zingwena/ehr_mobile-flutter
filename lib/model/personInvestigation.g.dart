// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personInvestigation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonInvestigation _$PersonInvestigationFromJson(Map<String, dynamic> json) {
  return PersonInvestigation(
    json['personId'] as String,
    json['investigationId'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['resultId'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$PersonInvestigationToJson(
        PersonInvestigation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'personId': instance.personId,
      'investigationId': instance.investigationId,
      'date': instance.date?.toIso8601String(),
      'resultId': instance.resultId,
    };
