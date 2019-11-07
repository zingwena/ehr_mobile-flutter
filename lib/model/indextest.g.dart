// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indextest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexTest _$IndexTestFromJson(Map<String, dynamic> json) {
  return IndexTest(
    json['personId'] as String,
    const CustomDateTimeConverter().fromJson(json['date'] as String),
  );
}

Map<String, dynamic> _$IndexTestToJson(IndexTest instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'date':
      const CustomDateTimeConverter().toJson(instance.date),

    };
