// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointmentoutcome.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentOutcome _$AppointmentOutcomeFromJson(Map<String, dynamic> json) {
  return AppointmentOutcome(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$AppointmentOutcomeToJson(AppointmentOutcome instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
