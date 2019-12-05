// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_view_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipViewDto _$RelationshipViewDtoFromJson(Map<String, dynamic> json) {
  return RelationshipViewDto(
    json['personId'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['relation'] as String,
  );
}

Map<String, dynamic> _$RelationshipViewDtoToJson(
        RelationshipViewDto instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'relation': instance.relation,
    };
