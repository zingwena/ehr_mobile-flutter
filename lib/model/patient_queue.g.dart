// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientQueue _$PatientQueueFromJson(Map<String, dynamic> json) {
  return PatientQueue(
    json['queue'] == null
        ? null
        : Queue.fromJson(json['queue'] as Map<String, dynamic>),
    json['visitId'] as String,
  );
}

Map<String, dynamic> _$PatientQueueToJson(PatientQueue instance) =>
    <String, dynamic>{
      'queue': instance.queue,
      'visitId': instance.visitId,
    };
