// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preTest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreTest _$PreTestFromJson(Map<String, dynamic> json) {
  return PreTest(
    json['htsId'] as String,
    json['htsApproach'] as String,
    json['htsModelId'] as String,
    json['newTest'] as bool,
    json['coupleCounselling'] as String,
    json['preTestInformationGiven'] as bool,
    json['optOutOfTest'] as bool,
    json['newTestPregLact'] as bool,
    json['purposeOfTestId'] as String,
  );
}

Map<String, dynamic> _$PreTestToJson(PreTest instance) => <String, dynamic>{
      'htsId': instance.htsId,
      'htsApproach': instance.htsApproach,
      'htsModelId': instance.htsModelId,
      'newTest': instance.newTest,
      'coupleCounselling': instance.coupleCounselling,
      'preTestInformationGiven': instance.preTestInformationGiven,
      'optOutOfTest': instance.optOutOfTest,
      'newTestPregLact': instance.newTestPregLact,
      'purposeOfTestId': instance.purposeOfTestId,
    };
