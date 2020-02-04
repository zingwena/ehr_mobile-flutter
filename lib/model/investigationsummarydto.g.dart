// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investigationsummarydto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestigationSummaryDto _$InvestigationSummaryDtoFromJson(Map<String, dynamic> json) {
  return InvestigationSummaryDto(
    json['testName'] as String,
    const CustomDateTimeConverter().fromJson(json['testDate'] as String),
    json['result'] as String,
  );
}

Map<String, dynamic> _$InvestigationSummaryDtoToJson(
    InvestigationSummaryDto instance) =>
    <String, dynamic>{
      'testName': instance.testName,
      'testDate': const CustomDateTimeConverter().toJson(instance.testDate),
      'result': instance.result,
    };
