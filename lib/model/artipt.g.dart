// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtIpt _$ArtIptFromJson(Map<String, dynamic> json) {
  return ArtIpt(
    json['visitId'] as String,
    json['artId'] as String,
    json['reason'] as String,
    const CustomDateTimeConverter().fromJson(json['date'] as String),
    json['iptStatus'] as String,


  );
}

Map<String, dynamic> _$ArtIptToJson(ArtIpt instance) => <String, dynamic>{
      'visitId': instance.visitId,
      'artId': instance.artId,
      'reason': instance.reason,
      'date': const CustomDateTimeConverter().toJson(instance.date),
      'iptStatus': instance.iptStatus,
    };
