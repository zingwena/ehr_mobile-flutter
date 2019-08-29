// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testKit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestKit _$TestKitFromJson(Map<String, dynamic> json) {
  return TestKit(
    json['id'] as int,
    json['code'] as String,
    json['name'] as String,
    json['description'] as String,
    json['level'] as String,
  );
}

Map<String, dynamic> _$TestKitToJson(TestKit instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'level': instance.level,
    };
