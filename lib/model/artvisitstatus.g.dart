// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artvisitstatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtVisitStatus _$ArtVisitStatusFromJson(Map<String, dynamic> json) {
  return ArtVisitStatus(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$ArtVisitStatusToJson(ArtVisitStatus instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
};
