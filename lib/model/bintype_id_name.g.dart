// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bintype_id_name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BinTypeIdName _$BinTypeIdNameFromJson(Map<String, dynamic> json) {
  return BinTypeIdName(
    json['binType'] as String,
    json['name'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$BinTypeIdNameToJson(BinTypeIdName instance) =>
    <String, dynamic>{
      'binType': instance.binType,
      'name': instance.name,
      'id': instance.id,
    };
