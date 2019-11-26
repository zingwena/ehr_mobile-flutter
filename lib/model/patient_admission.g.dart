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

  );
}

Map<String, dynamic> _$PatientAdmissionToJson(PatientAdmission instance) => <String, dynamic>{
  'personId': instance.personId,
  'queue': instance.queue,
};
