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
    json['age'] == null
        ? null
        : Age.fromJson(json['age'] as Map<String, dynamic>),
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  )
    ..status = json['status'] as String
    ..nationalityId = json['nationalityId'] as String
    ..countryId = json['countryId'] as String;
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
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
      'countryId': instance.countryId,
      'address': instance.address,
      'age': instance.age,
    };
Person _$PersonFromMap(Map<String, dynamic> json) {
  var person=Person(
    json['id'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    const SexConverter().fromInt(json['sex']),
    json['nationalId'] as String,
    const CustomDateTimeConverter().fromInt(json['birthDate']),
    const SexConverter().fromInt(json['selfIdentifiedGender']),
    json['religionId'] as String,
    json['occupationId'] as String,
    json['maritalStatusId'] as String,
    json['educationLevelId'] as String,
    json['age'],
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  );

  person.status='${json['status']}';
  Address address=Address(json['street'],json['town'],json['city']);
  person.address=address;

  person.nationalityId=json['nationalityId'];
  person.countryId = json['countryId'];
  return person;
}

Map<String, dynamic> _$PersonToEhrJson(Person instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'sex': instance.sex,
  'nationalId': instance.nationalId,
  'birthDate': const CustomDateTimeConverter().toSqlDate(instance.birthDate),
  'selfIdentifiedGender': instance.selfIdentifiedGender,
  'religionId': instance.religionId,
  'occupationId': instance.occupationId,
  'maritalStatusId': instance.maritalStatusId,
  'educationLevelId': instance.educationLevelId,
  'nationalityId': instance.nationalityId,
  'countryId': instance.countryId,
  'addressDto': instance.address,
  'gender':instance.sex,
  'phoneNumber1':instance.phoneNumber1,
  'phoneNumber2':instance.phoneNumber2,
};
