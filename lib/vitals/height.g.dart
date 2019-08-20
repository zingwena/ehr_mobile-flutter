// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Height _$HeightFromJson(Map<String, dynamic> json) {
  return Height()
    ..id = json['id'] as int
    ..visitId = json['visitId'] as int
    ..dateTime = json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String)
    ..value = json['value'] as String;
}

Map<String, dynamic> _$HeightToJson(Height instance) => <String, dynamic>{
      'id': instance.id,
      'visitId': instance.visitId,
      'dateTime': instance.dateTime?.toIso8601String(),
      'value': instance.value,
    };
