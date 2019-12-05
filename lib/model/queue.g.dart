// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Queue _$QueueFromJson(Map<String, dynamic> json) {
  return Queue(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$QueueToJson(Queue instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
