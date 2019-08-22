// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pulse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pulse _$PulseFromJson(Map<String, dynamic> json) {
  return Pulse()
    ..id = json['id'] as int
    ..visitId = json['visitId'] as int
    ..dateTime = json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String)
    ..value = json['value'] as String;
}

Map<String, dynamic> _$PulseToJson(Pulse instance) => <String, dynamic>{
      'id': instance.id,
      'visitId': instance.visitId,
      'dateTime': instance.dateTime?.toIso8601String(),
      'value': instance.value,
    };
