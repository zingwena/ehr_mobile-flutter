// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artoi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtOi _$ArtOiFromJson(Map<String, dynamic> json) {
  return ArtOi(
    json['id'] as String,
    json['artId'] as String,
    const CustomDateTimeConverter().fromJson(json['date'] as String),
    json['oi'] == null
        ? null
        : NameCode.fromJson(json['oi'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ArtOiToJson(ArtOi instance) => <String, dynamic>{
      'id': instance.id,
      'artId': instance.artId,
      'date': const CustomDateTimeConverter().toJson(instance.date),
      'oi': instance.oi,
    };
