// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investigationsummarydto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestigationSummaryDto _$InvestigationSummaryDtoFromJson(Map<String, dynamic> json) {
  return InvestigationSummaryDto(
    json['testName'] as String,
    json['testDate'] == null ? null : DateTime.parse(json['testDate'] as String),
    json['result'] as String,
  );
}

Map<String, dynamic> _$InvestigationSummaryDtoToJson(InvestigationSummaryDto instance) =>
    <String, dynamic>{
      'testName': instance.testName,
      'testDate': instance.testDate,
      'result': instance.result,
    };
