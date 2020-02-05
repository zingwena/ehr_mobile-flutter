// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artvisit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtVisit _$ArtVisitFromJson(Map<String, dynamic> json) {
  return ArtVisit(
    json['id'] as String,
    json['artId'] as String,
    json['visitId'] as String,
    json['visitType'] as String,
    json['functionalStatus'] as String,
    json['visitStatus'] as String,
    const CustomDateTimeConverter()
        .fromJson(json['ancFirstBookingDate'] as String),
    json['lactatingStatus'] as String,
    json['familyPlanningStatus'] as String,
    json['tbStatus'] as String,
    json['stage'] as String,

  );
}

Map<String, dynamic> _$ArtVisitToJson(ArtVisit instance) => <String, dynamic>{
      'id': instance.id,
      'artId': instance.artId,
      'visitId': instance.visitId,
      'visitType': instance.visitType,
      'functionalStatus': instance.functionalStatus,
      'visitStatus': instance.visitStatus,
      'ancFirstBookingDate':
          const CustomDateTimeConverter().toJson(instance.ancFirstBookingDate),
      'lactatingStatus': instance.lactatingStatus,
      'familyPlanningStatus': instance.familyPlanningStatus,
      'tbStatus': instance.tbStatus,
   'stage': instance.stage
    };
