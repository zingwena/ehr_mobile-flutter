// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respiratory_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespiratoryRate _$RespiratoryRateFromJson(Map<String, dynamic> json) {
  return RespiratoryRate()
    ..id = json['id'] as String
    ..visitId = json['visitId'] as String
    ..dateTime = json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String)
    ..value = json['value'] as String;
}

Map<String, dynamic> _$RespiratoryRateToJson(RespiratoryRate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitId': instance.visitId,
      'dateTime': instance.dateTime?.toIso8601String(),
      'value': instance.value,
    };
