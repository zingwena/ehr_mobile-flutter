// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discharge_patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DischargePatient _$DischargePatientFromJson(Map<String, dynamic> json) {
  return DischargePatient(
    json['visitId'] as String,
    const CustomDateTimeConverter().fromJson(json['dischargeDate'] as String),
  );
}

Map<String, dynamic> _$DischargePatientToJson(DischargePatient instance) =>
    <String, dynamic>{
      'visitId': instance.visitId,
      'dischargeDate':
          const CustomDateTimeConverter().toJson(instance.dischargeDate),
    };
