// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sexualhistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SexualHistory _$SexualHistoryFromJson(Map<String, dynamic> json) {
  return SexualHistory(
    json['personId'] as String,
    json['sexuallyActive'] as bool,
    json['sexWithMaleDate'] == null
        ? null
        : DateTime.parse(json['sexWithMaleDate'] as String),
    json['sexWithFemaleDate'] == null
        ? null
        : DateTime.parse(json['sexWithFemaleDate'] as String),
    json['numberOfSexualPartners'] as int,
    json['numberOfSexualPartnersLastTwelveMonths'] as int,
  );
}

Map<String, dynamic> _$SexualHistoryToJson(SexualHistory instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'sexuallyActive': instance.sexuallyActive,
      'sexWithMaleDate': instance.sexWithMaleDate?.toIso8601String(),
      'sexWithFemaleDate': instance.sexWithFemaleDate?.toIso8601String(),
      'numberOfSexualPartners': instance.numberOfSexualPartners,
      'numberOfSexualPartnersLastTwelveMonths':
          instance.numberOfSexualPartnersLastTwelveMonths,
    };
