// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'htsRegistration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HtsRegistration _$HtsRegistrationFromJson(Map<String, dynamic> json) {
  return HtsRegistration(
    json['id'] as int,
    json['htsType'] as String,
    const CustomDateTimeConverter().fromJson(json['dateOfHivTest'] as String),
    json['entryPointId'] as String,
  );
}

Map<String, dynamic> _$HtsRegistrationToJson(HtsRegistration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateOfHivTest':
          const CustomDateTimeConverter().toJson(instance.dateOfHivTest),
      'htsType': instance.htsType,
      'entryPointId': instance.entryPointId,
    };
