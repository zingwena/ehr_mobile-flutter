// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weight _$WeightFromJson(Map<String, dynamic> json) {
  return Weight()
    ..id = json['id'] as String
    ..visitId = json['visitId'] as String
    ..personId = json['personId'] as String
    ..dateTime = json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String)
    ..value = json['value'] as String;
}

Map<String, dynamic> _$WeightToJson(Weight instance) => <String, dynamic>{
      'id': instance.id,
      'visitId': instance.visitId,
      'personId': instance.personId,
      'dateTime': instance.dateTime?.toIso8601String(),
      'value': instance.value,
    };
