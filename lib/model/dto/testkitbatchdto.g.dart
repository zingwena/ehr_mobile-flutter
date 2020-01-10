// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testkitbatchdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestKitBatchDto _$TestKitBatchDtoFromJson(Map<String, dynamic> json) {
  return TestKitBatchDto(
    json['binType'] as String,
    json['binId'] as String,
    json['testKitId'] as String,
  );
}

Map<String, dynamic> _$TestKitBatchDtoToJson(TestKitBatchDto instance) =>
    <String, dynamic>{
      'binType': instance.binType,
      'binId': instance.binId,
      'testKitId': instance.testKitId,
    };
