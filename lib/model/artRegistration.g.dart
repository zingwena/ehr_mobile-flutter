// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artRegistration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtRegistration _$ArtRegistrationFromJson(Map<String, dynamic> json) {
  return ArtRegistration(
    json['personId'] as String,
    const CustomDateTimeConverter()
        .fromJson(json['dateOfEnrolmentIntoCare'] as String),
    const CustomDateTimeConverter().fromJson(json['dateOfHivTest'] as String),
    json['oiArtNumber'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$ArtRegistrationToJson(ArtRegistration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'personId': instance.personId,
      'dateOfEnrolmentIntoCare': const CustomDateTimeConverter()
          .toJson(instance.dateOfEnrolmentIntoCare),
      'dateOfHivTest':
          const CustomDateTimeConverter().toJson(instance.dateOfHivTest),
      'oiArtNumber': instance.oiArtNumber,
    };
