// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artsign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtSign _$ArtSignFromJson(Map<String, dynamic> json) {
  return ArtSign(
    json['id'] as String,
    json['artId'] as String,
    const CustomDateTimeConverter().fromJson(json['date'] as String),
    json['sign'] == null
        ? null
        : NameCode.fromJson(json['sign'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ArtSignToJson(ArtSign instance) => <String, dynamic>{
      'id': instance.id,
      'artId': instance.artId,
      'date': const CustomDateTimeConverter().toJson(instance.date),
      'sign': instance.sign,
    };
