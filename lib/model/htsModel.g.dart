// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'htsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HtsModel _$HtsModelFromJson(Map<String, dynamic> json) {
  return HtsModel(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$HtsModelToJson(HtsModel instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
