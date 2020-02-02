// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'familyplanningstatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyPlanningStatus _$FamilyPlanningStatusFromJson(Map<String, dynamic> json) {
  return FamilyPlanningStatus(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$FamilyPlanningStatusToJson(FamilyPlanningStatus instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
};
