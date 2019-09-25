// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arv_combination_regimen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArvCombinationRegimen _$ArvCombinationRegimenFromJson(
    Map<String, dynamic> json) {
  return ArvCombinationRegimen(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$ArvCombinationRegimenToJson(
        ArvCombinationRegimen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
