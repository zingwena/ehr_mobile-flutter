// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    json['firstName'] as String,
    json['lastName'] as String,
    json['sex'] as String,
    json['nationalId'] as String,
    json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    json['selfIdentifiedGender'] as String,
    json['religion'] as String,
    json['occupation'] as String,
    json['maritalStatus'] as String,
    json['educationLevel'] as String,
  )
    ..id = json['id'] as int
    ..age = json['age'] as int
    ..schoolHouse = json['schoolHouse'] as String
    ..suburbVillage = json['suburbVillage'] as String
    ..town = json['town'] as String;
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'sex': instance.sex,
      'nationalId': instance.nationalId,
      'birthDate': instance.birthDate?.toIso8601String(),
      'age': instance.age,
      'selfIdentifiedGender': instance.selfIdentifiedGender,
      'religion': instance.religion,
      'occupation': instance.occupation,
      'maritalStatus': instance.maritalStatus,
      'educationLevel': instance.educationLevel,
      'schoolHouse': instance.schoolHouse,
      'suburbVillage': instance.suburbVillage,
      'town': instance.town,
    };
