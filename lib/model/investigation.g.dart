// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investigation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Investigation _$InvestigationFromJson(Map<String, dynamic> json) {
  return Investigation(
    json['investigationId'] as String,
    json['sample'] as String,
    json['test'] as String,
  );
}

Map<String, dynamic> _$InvestigationToJson(Investigation instance) =>
    <String, dynamic>{
      'investigationId': instance.investigationId,
      'sample': instance.sample,
      'test': instance.test,
    };
