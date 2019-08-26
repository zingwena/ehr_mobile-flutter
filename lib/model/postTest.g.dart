// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postTest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostTest _$PostTestFromJson(Map<String, dynamic> json) {
  return PostTest(
    json['id'] as int,
    json['firstName'] as String,
    json['lastName'] as String,
    json['reasonForNotIssuingResult'] == null
        ? null
        : ReasonForNotIssuingResult.fromJson(
            json['reasonForNotIssuingResult'] as Map<String, dynamic>),
    json['dateOfPostTestCounsel'] == null
        ? null
        : DateTime.parse(json['dateOfPostTestCounsel'] as String),
    json['finalResult'] as String,
    json['resultReceived'] as String,
  );
}

Map<String, dynamic> _$PostTestToJson(PostTest instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'dateOfPostTestCounsel':
          instance.dateOfPostTestCounsel?.toIso8601String(),
      'resultReceived': instance.resultReceived,
      'finalResult': instance.finalResult,
      'lastName': instance.lastName,
      'reasonForNotIssuingResult': instance.reasonForNotIssuingResult?.toJson(),
    };
