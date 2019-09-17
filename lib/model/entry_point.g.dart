// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryPoint _$EntryPointFromJson(Map<String, dynamic> json) {
  return EntryPoint(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$EntryPointToJson(EntryPoint instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
