// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artfollowupvisit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtFollowUpVisit _$ArtFollowUpVisitFromJson(Map<String, dynamic> json) {
  return ArtFollowUpVisit(
    json['id'] as String,
    json['artAppointmentId'] as String,
    json['outcome'] == null
        ? null
        : NameCode.fromJson(json['outcome'] as Map<String, dynamic>),
    const CustomDateTimeConverter().fromJson(json['date'] as String),
  );
}

Map<String, dynamic> _$ArtFollowUpVisitToJson(ArtFollowUpVisit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artAppointmentId': instance.artAppointmentId,
      'outcome': instance.outcome,
      'date': const CustomDateTimeConverter().toJson(instance.date),
    };
