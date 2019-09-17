// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visit _$VisitFromJson(Map<String, dynamic> json) {
  return Visit()
    ..visitId = json['visitId'] as String
    ..personId = json['personId'] as String;
}

Map<String, dynamic> _$VisitToJson(Visit instance) => <String, dynamic>{
      'visitId': instance.visitId,
      'personId': instance.personId,
    };
