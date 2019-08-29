// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    json['id'] as int,
    json['firstName'] as String,
    json['lastName'] as String,
    json['sex'] as String,
    json['nationalId'] as String,
    json['selfIdentifiedGender'] as String,
    json['religionId'] as String,
    json['occupationId'] as String,
    json['maritalStatusId'] as String,
    json['educationLevelId'] as String,
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  )
    ..birthDate =
        const CustomDateTimeConverter().fromJson(json['birthDate'] as String)
    ..nationalityId = json['nationalityId'] as String
    ..countryId = json['countryId'] as String;
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'sex': instance.sex,
      'nationalId': instance.nationalId,
      'birthDate': const CustomDateTimeConverter().toJson(instance.birthDate),
      'selfIdentifiedGender': instance.selfIdentifiedGender,
      'religionId': instance.religionId,
      'occupationId': instance.occupationId,
      'maritalStatusId': instance.maritalStatusId,
      'educationLevelId': instance.educationLevelId,
      'nationalityId': instance.nationalityId,
      'countryId': instance.countryId,
      'address': instance.address,
    };
