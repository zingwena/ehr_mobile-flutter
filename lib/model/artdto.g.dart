// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artdto _$ArtdtoFromJson(Map<String, dynamic> json) {
  return Artdto(
    json['personId'] as String,
    const CustomDateTimeConverter().fromJson(json['date'] as String),
    json['artNumber'] as String,
    const CustomDateTimeConverter().fromJson(json['dateOfHivTest'] as String),
    const CustomDateTimeConverter().fromJson(json['dateEnrolled'] as String),
    json['linkageFrom'] as String,
    const CustomDateTimeConverter()
        .fromJson(json['dateHivConfirmed'] as String),
    json['linkageNumber'] as String,
    json['hivTestUsed'] as String,
    json['otherInstitution'] as String,
    json['testReason'] as String,
    json['reTested'] as bool,
    const CustomDateTimeConverter().fromJson(json['dateRetested'] as String),
    json['facility'] as String,

  );
}


Map<String, dynamic> _$ArtdtoToJson(Artdto instance) => <String, dynamic>{
      'personId': instance.personId,
      'date': const CustomDateTimeConverter().toJson(instance.date),
      'artNumber': instance.artNumber,
      'dateOfHivTest':
          const CustomDateTimeConverter().toJson(instance.dateOfHivTest),
      'dateEnrolled':
          const CustomDateTimeConverter().toJson(instance.dateEnrolled),
      'linkageFrom': instance.linkageFrom,
      'dateHivConfirmed':
          const CustomDateTimeConverter().toJson(instance.dateHivConfirmed),
      'linkageNumber': instance.linkageNumber,
      'hivTestUsed': instance.hivTestUsed,
      'otherInstitution': instance.otherInstitution,
      'testReason': instance.testReason,
      'reTested': instance.reTested,
      'dateRetested':
          const CustomDateTimeConverter().toJson(instance.dateRetested),
      'facility': instance.facility,
    };
