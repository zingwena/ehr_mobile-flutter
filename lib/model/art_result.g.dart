// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtResult _$ArtResultFromJson(Map<String, dynamic> json) {
  return ArtResult(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$ArtResultToJson(ArtResult instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
