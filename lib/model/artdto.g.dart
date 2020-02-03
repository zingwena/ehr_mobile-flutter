// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artdto _$ArtdtoFromJson(Map<String, dynamic> json) {
  return Artdto(
    json['personId'] as String,
    const CustomDateTimeConverter()
        .fromJson(json['date'] as String),
    json['artNumber'] as String,
    json['enlargedLymphNode'] as bool,
    json['pallor'] as bool,
    json['jaundice'] as bool,
    json['cyanosis'] as bool,
    json['mentalStatus'] as String,
    json['centralNervousSystem'] as String,
    const CustomDateTimeConverter()
        .fromJson(json['dateOfHivTest'] as String),
    const CustomDateTimeConverter()
        .fromJson(json['dateEnrolled'] as String),
    json['tracing'] as bool,
    json['followUp'] as bool,
    json['hivStatus'] as bool,
    json['relation'] as String,
    const CustomDateTimeConverter()
        .fromJson(json['dateOfDisclosure'] as String),
    json['reason'] as String,
    json['linkageFrom'] as String,
    const CustomDateTimeConverter()
        .fromJson(json['dateHivConfirmed'] as String),
    json['linkageNumber'] as String,
    json['hivTestUsed'] as String,
    json['otherInstitution'] as String,
    json['testReason'] == null
        ? null
        : NameCode.fromJson(json['testReason'] as Map<String, dynamic>),
    json['reTested'] as bool,
    const CustomDateTimeConverter()
        .fromJson(json['dateRetested'] as String),
    json['facility'] == null
        ? null
        : NameCode.fromJson(json['facility'] as Map<String, dynamic>),

  );
}

Map<String, dynamic> _$ArtdtoToJson(
    Artdto instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'date':  const CustomDateTimeConverter().toJson(instance.date),
      'artNumber': instance.artNumber,
      'enlargedLymphNode': instance.enlargedLymphNode,
      'pallor': instance.pallor,
      'jaundice': instance.jaundice,
      'cyanosis': instance.cyanosis,
      'mentalStatus': instance.mentalStatus,
      'centralNervousSystem': instance.centralNervousSystem,
      'dateOfHivTest': const CustomDateTimeConverter().toJson(instance.dateOfHivTest),
      'tracing': instance.tracing,
      'followUp': instance.followUp,
      'hivStatus': instance.hivStatus,
      'relation': instance.relation,
      'dateEnrolled': const CustomDateTimeConverter().toJson(instance.dateEnrolled),
      'dateOfDisclosure': const CustomDateTimeConverter().toJson(instance.dateOfDisclosure),
      'reason': instance.reason,
      'linkageFrom': instance.linkageFrom,
      'dateHivConfirmed': const CustomDateTimeConverter().toJson(instance.dateHivConfirmed),
      'linkageNumber': instance.linkageNumber,
      'hivTestUsed': instance.hivTestUsed,
      'otherInstitution': instance.otherInstitution,
      'testReason': instance.testReason,
      'reTested': instance.reTested,
      'dateRetested': const CustomDateTimeConverter().toJson(instance.dateRetested),
      'facility': instance.facility,

    };
