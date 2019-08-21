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
    json['occupation'] == null
        ? null
        : Occupation.fromJson(json['occupation'] as Map<String, dynamic>),
    json['maritalStatus'] == null
        ? null
        : MaritalStatus.fromJson(json['maritalStatus'] as Map<String, dynamic>),
    json['educationLevel'] == null
        ? null
        : EducationLevel.fromJson(
            json['educationLevel'] as Map<String, dynamic>),
  )
    ..id = json['id'] as int
    ..phoneNumber = json['phoneNumber'] as String
    ..country = json['country'] == null
        ? null
        : Country.fromJson(json['country'] as Map<String, dynamic>)
    ..nationality = json['nationality'] == null
        ? null
        : Nationality.fromJson(json['nationality'] as Map<String, dynamic>)
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
      'phoneNumber': instance.phoneNumber,
      'country': instance.country,
      'educationLevel': instance.educationLevel,
      'maritalStatus': instance.maritalStatus,
      'nationality': instance.nationality,
      'occupation': instance.occupation,
      'birthDate': instance.birthDate?.toIso8601String(),
      'age': instance.age,
      'selfIdentifiedGender': instance.selfIdentifiedGender,
      'religion': instance.religion,
      'schoolHouse': instance.schoolHouse,
      'suburbVillage': instance.suburbVillage,
      'town': instance.town,
    };
