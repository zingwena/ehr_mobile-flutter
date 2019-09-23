// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodPressure _$BloodPressureFromJson(Map<String, dynamic> json) {
  return BloodPressure()
    ..id = json['id'] as String
    ..visitId = json['visitId'] as String
    ..personId = json['personId'] as String
    ..dateTime = json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String)
    ..systolic = json['systolic'] as String
    ..diastolic = json['diastolic'] as String;
}

Map<String, dynamic> _$BloodPressureToJson(BloodPressure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitId': instance.visitId,
      'personId': instance.personId,
      'dateTime': instance.dateTime?.toIso8601String(),
      'systolic': instance.systolic,
      'diastolic': instance.diastolic,
    };
