// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artfollowupcall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtFollowUpCall _$ArtFollowUpCallFromJson(Map<String, dynamic> json) {
  return ArtFollowUpCall(
    json['id'] as String,
    json['artAppointmentId'] as String,
    json['outcome'] as String,
    const CustomDateTimeConverter().fromJson(json['date'] as String),
    json['followUpType'] as String,

  );
}

Map<String, dynamic> _$ArtFollowUpCallToJson(ArtFollowUpCall instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artAppointmentId': instance.artAppointmentId,
      'outcome': instance.outcome,
      'date': const CustomDateTimeConverter().toJson(instance.date),
      'followUpType': instance.followUpType
    };
