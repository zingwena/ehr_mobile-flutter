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
    json['visitType'] == null
        ? null
        : NameCode.fromJson(json['visitType'] as Map<String, dynamic>),
    json['functionalStatus'] == null
        ? null
        : NameCode.fromJson(json['functionalStatus'] as Map<String, dynamic>),
    json['visitStatus'] == null
        ? null
        : NameCode.fromJson(json['visitStatus'] as Map<String, dynamic>),
    const CustomDateTimeConverter()
        .fromJson(json['ancFirstBookingDate'] as String),
    json['lactatingStatus'] == null
        ? null
        : NameCode.fromJson(json['lactatingStatus'] as Map<String, dynamic>),
    json['familyPlanningStatus'] == null
        ? null
        : NameCode.fromJson(
            json['familyPlanningStatus'] as Map<String, dynamic>),
    json['tbStatus'] == null
        ? null
        : NameCode.fromJson(json['tbStatus'] as Map<String, dynamic>),
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
    };
