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
    json['reasonForNotIssuingResult'] as String,
    json['finalResult'] as String,
    json['consentToIndexTesting'] as bool,
    json['postTestCounselled'] as bool,

  );
}

Map<String, dynamic> _$PostTestToJson(PostTest instance) => <String, dynamic>{
      'htsId': instance.htsId,
      'datePostTestCounselled':
          instance.datePostTestCounselled,
      'resultReceived': instance.resultReceived,
      'reasonForNotIssuingResult': instance.reasonForNotIssuingResultId,
      'finalResult': instance.finalResult,
      'consentToIndexTesting': instance.consentToIndexTesting,
      'postTestCounselled': instance.postTestCounselled
    };
