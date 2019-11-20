// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relationship _$RelationshipFromJson(Map<String, dynamic> json) {
  return Relationship(
    json['personId'] as String,
    json['memberId'] as String,
    json['relation'] as String,
    json['typeOfContact'] as String,

  );
}


Map<String, dynamic> _$ReligionToJson(Relationship instance) => <String, dynamic>{
  'personId': instance.personId,
  'memberId': instance.memberId,
  'relation': instance.relation,
  'typeOfContact': instance.typeOfContact,
};
