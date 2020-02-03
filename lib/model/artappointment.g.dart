// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artappointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtAppointment _$ArtAppointmentFromJson(Map<String, dynamic> json) {
  return ArtAppointment(
    json['id'] as String,
    json['artId'] as String,
    json['reason'] == null
        ? null
        : NameCode.fromJson(json['reason'] as Map<String, dynamic>),
    const CustomDateTimeConverter().fromJson(json['date'] as String),
    json['followUpReason'] == null
        ? null
        : NameCode.fromJson(json['followUpReason'] as Map<String, dynamic>),
    const CustomDateTimeConverter().fromJson(json['followupDate'] as String),
    const CustomDateTimeConverter()
        .fromJson(json['appointmentOutcomeDate'] as String),
    json['appointmentOutcome'] == null
        ? null
        : NameCode.fromJson(json['appointmentOutcome'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ArtAppointmentToJson(ArtAppointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artId': instance.artId,
      'reason': instance.reason,
      'date': const CustomDateTimeConverter().toJson(instance.date),
      'followUpReason': instance.followUpReason,
      'followupDate':
          const CustomDateTimeConverter().toJson(instance.followupDate),
      'appointmentOutcomeDate': const CustomDateTimeConverter()
          .toJson(instance.appointmentOutcomeDate),
      'appointmentOutcome': instance.appointmentOutcome,
    };
