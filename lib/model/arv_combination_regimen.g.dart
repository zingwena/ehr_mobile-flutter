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
    json['regimen_type'] as String,
    json['age_group'] as String,

  );
}

Map<String, dynamic> _$ArvCombinationRegimenToJson(
        ArvCombinationRegimen instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'regimen_type': instance.regimen_type,
      'age_group': instance.age_group

    };
