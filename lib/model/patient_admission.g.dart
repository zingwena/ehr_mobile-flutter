// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_admission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientAdmission _$PatientAdmissionFromJson(Map<String, dynamic> json) {
  return PatientAdmission(
    json['personId'] as String,
    json['queue'] == null
        ? null
        : Queue.fromJson(json['queue'] as Map<String, dynamic>),
  )
    ..code = json['code'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$PatientAdmissionToJson(PatientAdmission instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'personId': instance.personId,
      'queue': instance.queue,
    };
