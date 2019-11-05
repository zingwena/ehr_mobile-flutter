// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sexualhistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SexualHistory _$SexualHistoryFromJson(Map<String, dynamic> json) {
  return SexualHistory(
    json['personId'] as String,
    json['sexuallyActive'] as bool,
    const CustomDateTimeConverter().fromJson(json['sexWithMaleDate'] as String),
    const CustomDateTimeConverter().fromJson(json['sexWithFemaleDate'] as String),
    const CustomDateTimeConverter().fromJson(json['date'] as String),
    json['numberOfSexualPartners'] as int,
    json['numberOfSexualPartnersLastTwelveMonths'] as int,

  );

}

Map<String, dynamic> _$SexualHistoryToJson(SexualHistory instance) => <String, dynamic>{
  'personId': instance.personId,
  'sexuallyActive': instance.sexuallyActive,
  'sexWithMaleDate': const CustomDateTimeConverter().toJson(instance.sexWithMaleDate),
  'sexWithFemaleDate': const CustomDateTimeConverter().toJson(instance.sexWithFemaleDate),
  'date':  const CustomDateTimeConverter().toJson(instance.date),
  'numberOfSexualPartners': instance.numberOfSexualPartners,
  'numberOfSexualPartnersLastTwelveMonths': instance.numberOfSexualPartnersLastTwelveMonths,

};
