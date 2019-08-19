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
    ..nationalId = json['nationalId'] as String;
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'personId': instance.personId,
      'nationalId': instance.nationalId,
    };
