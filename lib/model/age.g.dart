// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'age.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Age _$AgeFromJson(Map<String, dynamic> json) {
  return Age(
    json['years'] as int,
    json['months'] as int,
    json['days'] as int,
    json['person'] == null
        ? null
        : Person.fromJson(json['person'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AgeToJson(Age instance) => <String, dynamic>{
      'years': instance.years,
      'months': instance.months,
      'days': instance.days,
      'person': instance.person,
    };
