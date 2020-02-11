// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artappointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtAppointment _$ArtAppointmentFromJson(Map<String, dynamic> json) {
  return ArtAppointment(
    json['id'] as String,
    json['artId'] as String,
    json['reason'] as String,
    const CustomDateTimeConverter().fromJson(json['date'] as String),

  );
}

Map<String, dynamic> _$ArtAppointmentToJson(ArtAppointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artId': instance.artId,
      'reason': instance.reason,
      'date': const CustomDateTimeConverter().toJson(instance.date),

    };
