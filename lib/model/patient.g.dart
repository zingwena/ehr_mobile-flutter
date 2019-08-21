// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient()
    ..id = json['id'] as int
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..personId = json['personId'] as String
    ..nationalId = json['nationalId'] as String
    ..sex = json['sex'] as String
    ..birthDate = json['birthDate'] as String
    ..phoneNumber = json['phoneNumber'] as String
    ..country = json['country'] == null
        ? null
        : Country.fromJson(json['country'] as Map<String, dynamic>)
    ..educationLevel = json['educationLevel'] == null
        ? null
        : EducationLevel.fromJson(
            json['educationLevel'] as Map<String, dynamic>)
    ..maritalStatus = json['maritalStatus'] == null
        ? null
        : MaritalStatus.fromJson(json['maritalStatus'] as Map<String, dynamic>)
    ..nationality = json['nationality'] == null
        ? null
        : Nationality.fromJson(json['nationality'] as Map<String, dynamic>)
    ..occupation = json['occupation'] == null
        ? null
        : Occupation.fromJson(json['occupation'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'personId': instance.personId,
      'nationalId': instance.nationalId,
      'sex': instance.sex,
      'birthDate': instance.birthDate,
      'phoneNumber': instance.phoneNumber,
      'country': instance.country?.toJson(),
      'educationLevel': instance.educationLevel?.toJson(),
      'maritalStatus': instance.maritalStatus?.toJson(),
      'nationality': instance.nationality?.toJson(),
      'occupation': instance.occupation?.toJson(),
    };
