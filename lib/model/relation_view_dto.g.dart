// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_view_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipViewDto _$RelationshipFromJson(Map<String, dynamic> json) {
  return RelationshipViewDto(
    json['personId'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['relation'] as String,

  );
}

Map<String, dynamic> _$ReligionToJson(RelationshipViewDto instance) => <String, dynamic>{
  'personId': instance.personId,
  'memberId': instance.firstName,
  'relation': instance.lastName,
  'typeOfContact': instance.relation,
};
