// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postTest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostTest _$PostTestFromJson(Map<String, dynamic> json) {
  return PostTest(
    json['htsId'] as String,
    const CustomDateTimeConverter().fromJson(json['datePostTestCounselled'] as String),
    json['resultReceived'] as bool,
    json['reasonForNotIssuingResultId'] as String,
    json['finalResult'] as String,
    json['consentToIndexTesting'] as bool,
    json['postTestCounselled'] as bool,
  );
}

Map<String, dynamic> _$PostTestToJson(PostTest instance) => <String, dynamic>{
      'htsId': instance.htsId,
  'datePostTestCounselled':
      const CustomDateTimeConverter().toJson(instance.datePostTestCounselled),
      'resultReceived': instance.resultReceived,
      'reasonForNotIssuingResultId': instance.reasonForNotIssuingResultId,
      'finalResult': instance.finalResult,
      'consentToIndexTesting': instance.consentToIndexTesting,
      'postTestCounselled': instance.postTestCounselled,
    };
