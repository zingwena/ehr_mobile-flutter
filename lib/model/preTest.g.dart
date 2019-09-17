// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preTest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreTest _$PreTestFromJson(Map<String, dynamic> json) {
  return PreTest(
    json['htsId'] as String,
    json['htsApproach'] as String,
    json['htsModel'] == null
        ? null
        : HtsModel.fromJson(json['htsModel'] as Map<String, dynamic>),
    json['newTest'] as String,
    json['coupleCounselling'] as String,
    json['preTestInformationGiven'] as bool,
    json['optOutOfTest'] as String,
    json['newTestPregLact'] as String,
    json['purposeOfTest'] == null
        ? null
        : PurposeOfTest.fromJson(json['purposeOfTest'] as Map<String, dynamic>),
    json['reasonForNotIssuingResult'] == null
        ? null
        : ReasonForNotIssuingResult.fromJson(
            json['reasonForNotIssuingResult'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PreTestToJson(PreTest instance) => <String, dynamic>{
      'htsId': instance.htsId,
      'htsApproach': instance.htsApproach,
      'newTest': instance.newTest,
      'coupleCounselling': instance.coupleCounselling,
      'preTestInformationGiven': instance.preTestInformationGiven,
      'optOutOfTest': instance.optOutOfTest,
      'newTestPregLact': instance.newTestPregLact,
      'htsModel': instance.htsModel?.toJson(),
      'purposeOfTest': instance.purposeOfTest?.toJson(),
      'reasonForNotIssuingResult': instance.reasonForNotIssuingResult?.toJson(),
    };
