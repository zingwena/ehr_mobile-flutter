// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postTest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostTest _$PostTestFromJson(Map<String, dynamic> json) {
  return PostTest(
    json['htsId'] as String,
    json['datePostTestCounselled'] == null
        ? null
        : DateTime.parse(json['datePostTestCounselled'] as String),
    json['resultReceived'] as bool,
    json['reasonForNotIssuingResult'] == null
        ? null
        : ReasonForNotIssuingResult.fromJson(
            json['reasonForNotIssuingResult'] as Map<String, dynamic>),
    json['finalResult'] as String,
    json['consentToIndexTesting'] as bool,
  );
}

Map<String, dynamic> _$PostTestToJson(PostTest instance) => <String, dynamic>{
      'htsId': instance.htsId,
      'datePostTestCounselled':
          instance.datePostTestCounselled?.toIso8601String(),
      'resultReceived': instance.resultReceived,
      'reasonForNotIssuingResult': instance.reasonForNotIssuingResult?.toJson(),
      'finalResult': instance.finalResult,
      'consentToIndexTesting': instance.consentToIndexTesting,
    };
