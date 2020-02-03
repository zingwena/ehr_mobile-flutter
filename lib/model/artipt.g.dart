// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtIpt _$ArtIptFromJson(Map<String, dynamic> json) {
  return ArtIpt(
    json['id'] as String,
    json['artId'] as String,
    json['reason'] == null
        ? null
        : NameCode.fromJson(json['reason'] as Map<String, dynamic>),
    const CustomDateTimeConverter().fromJson(json['date'] as String),
    json['iptStatus'] == null
        ? null
        : NameCode.fromJson(json['iptStatus'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ArtIptToJson(ArtIpt instance) => <String, dynamic>{
      'id': instance.id,
      'artId': instance.artId,
      'reason': instance.reason,
      'date': const CustomDateTimeConverter().toJson(instance.date),
      'iptStatus': instance.iptStatus,
    };
