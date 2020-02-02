// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'functionalstatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FunctionalStatus _$FunctionalStatusFromJson(Map<String, dynamic> json) {
  return FunctionalStatus(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$FunctionalStatusToJson(FunctionalStatus instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
};
