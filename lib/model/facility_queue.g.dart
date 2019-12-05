// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityQueue _$FacilityQueueFromJson(Map<String, dynamic> json) {
  return FacilityQueue(
    json['queue'] == null
        ? null
        : Queue.fromJson(json['queue'] as Map<String, dynamic>),
    json['facility'] == null
        ? null
        : Facility.fromJson(json['facility'] as Map<String, dynamic>),
    json['department'] == null
        ? null
        : Department.fromJson(json['department'] as Map<String, dynamic>),
    json['beds'] as int,
  );
}

Map<String, dynamic> _$FacilityQueueToJson(FacilityQueue instance) =>
    <String, dynamic>{
      'queue': instance.queue,
      'facility': instance.facility,
      'department': instance.department,
      'beds': instance.beds,
    };
