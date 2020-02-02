// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artsymptom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtSymptom _$ArtSymptomFromJson(Map<String, dynamic> json) {
  return ArtSymptom(
    json['id'] as String,
    json['artId'] as String,
    const CustomDateTimeConverter()
        .fromJson(json['date'] as String),
    json['symptom'] == null
        ? null
        : NameCode.fromJson(json['symptom'] as Map<String, dynamic>),
  );
}


Map<String, dynamic> _$ArtSymptomToJson(
    ArtSymptom instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artId': instance.artId,
      'date': instance.date,
      'symptom': instance.symptom,
    };
