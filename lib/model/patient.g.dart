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
    const CustomDateTimeConverter().fromJson(json['birthDate'] as String),
    json['nationalId'] as String,
    json['selfIdentifiedGender'] as String,
    json['religion'] as String,
    json['occupation'] as String,
    json['maritalStatus'] as String,
    json['educationLevel'] as String,
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  )
    ..nationality = json['nationality'] as String
    ..countryOfBirth = json['countryOfBirth'] as String;
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'sex': instance.sex,
      'nationalId': instance.nationalId,
      'birthDate': const CustomDateTimeConverter().toJson(instance.birthDate),
      'selfIdentifiedGender': instance.selfIdentifiedGender,
      'religion': instance.religion,
      'occupation': instance.occupation,
      'maritalStatus': instance.maritalStatus,
      'educationLevel': instance.educationLevel,
      'nationality': instance.nationality,
      'countryOfBirth': instance.countryOfBirth,
      'address': instance.address,
    };
