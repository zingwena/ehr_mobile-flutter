// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return Department(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$DepartmentToJson(Department instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
};
