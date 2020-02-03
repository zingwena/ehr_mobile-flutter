// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artstatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtStatus _$ArtStatusFromJson(Map<String, dynamic> json) {
  return ArtStatus(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$ArtStatusToJson(ArtStatus instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
