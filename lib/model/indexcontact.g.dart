// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexcontact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexContact _$IndexContactFromJson(Map<String, dynamic> json) {
  return IndexContact(
    json['indexTestId'] as String,
    json['personId'] as String,
    json['relation'] as String,
    json['hivStatus'] as String,
    const CustomDateTimeConverter().fromJson(json['dateOfHivStatus'] as String),
    json['fearOfIpv'] as bool,
    json['disclosureMethodPlanId'] as String,
    json['testingPlanId'] as String,
    json['disclosureStatus'] as bool,
    json['disclosureMethodId'] as String,



  );
}

Map<String, dynamic> _$IndexContactToJson(IndexContact instance) =>
    <String, dynamic>{
      'indexTestId': instance.indexTestId,
      'personId': instance.personId,
      'relation': instance.relation,
      'hivStatus': instance.hivStatus,
      'dateOfHivStatus':const CustomDateTimeConverter().toJson(instance.dateOfHivStatus),
      'fearOfIpv': instance.fearOfIpv,
      'disclosureMethodPlanId': instance.disclosureMethodPlanId,
      'testingPlanId': instance.testingPlanId,
      'disclosureStatus': instance.disclosureStatus,
      'disclosureMethodId': instance.disclosureMethodId
    };

