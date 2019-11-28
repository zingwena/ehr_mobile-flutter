// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    json['id'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['sex'] as String,
    json['nationalId'] as String,
    const CustomDateTimeConverter().fromJson(json['birthDate'] as String),
    json['selfIdentifiedGender'] as String,
    json['religionId'] as String,
    json['occupationId'] as String,
    json['maritalStatusId'] as String,
    json['educationLevelId'] as String,
    json['age'] == null ? null: Age.fromJson(json['age'] as Map<String, dynamic>),

    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  )
    ..nationalityId = json['nationalityId'] as String
    ..countryId = json['countryId'] as String;
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'sex': instance.sex,
      'nationalId': instance.nationalId,
      'birthDate': const CustomDateTimeConverter().toJson(instance.birthDate),
      'selfIdentifiedGender': instance.selfIdentifiedGender,
      'religionId': instance.religionId,
      'occupationId': instance.occupationId,
      'maritalStatusId': instance.maritalStatusId,
      'educationLevelId': instance.educationLevelId,
      'nationalityId': instance.nationalityId,
      'age': instance.age,
      'countryId': instance.countryId,
      'address': instance.address,
    };
