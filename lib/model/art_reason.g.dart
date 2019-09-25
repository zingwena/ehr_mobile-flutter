// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_reason.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtReason _$ArtReasonFromJson(Map<String, dynamic> json) {
  return ArtReason(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$ArtReasonToJson(ArtReason instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
