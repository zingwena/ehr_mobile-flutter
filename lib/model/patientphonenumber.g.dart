// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientphonenumber.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientPhoneNumber _$PatientPhoneNumberFromJson(Map<String, dynamic> json) {
  return PatientPhoneNumber(
    json['personId'] as String,
    json['phoneNumber1'] as String,
    json['phoneNumber2'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$PatientPhoneNumberToJson(PatientPhoneNumber instance) =>
    <String, dynamic>{
      'id': instance.id,
      'personId': instance.personId,
      'phoneNumber1': instance.phoneNumber1,
      'phoneNumber2': instance.phoneNumber2,
    };
