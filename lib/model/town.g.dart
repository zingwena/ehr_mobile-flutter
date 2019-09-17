// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'town.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Town _$TownFromJson(Map<String, dynamic> json) {
  return Town(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$TownToJson(Town instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
