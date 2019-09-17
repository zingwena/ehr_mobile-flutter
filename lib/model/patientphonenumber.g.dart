// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientphonenumber.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientPhoneNumber _$PatientPhoneNumberFromJson(Map<String, dynamic> json) {
  return PatientPhoneNumber(
    json['patientId'] as int,
    json['phonenumber_1'] as String,
    json['phonenumber_2'] as String,
  );
}

Map<String, dynamic> _$PatientPhoneNumberToJson(PatientPhoneNumber instance) => <String, dynamic>{
  'patientId': instance.patientId,
  'phonenumber_1': instance.phonenumber_1,
  'phonenumber_2': instance.phonenumber_2,
};


