// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Batch _$BatchFromJson(
    Map<String, dynamic> json) {
  return Batch(
    json['batchNumber'] as String,
    const CustomDateTimeConverter().fromJson(json['expiryDate'] as String),
    json['textKitId'] as String,
    json['testKitName'] as String,
  );
}


Map<String, dynamic> _$BatchToJson(
    Batch instance) =>
    <String, dynamic>{
      'batchNumber': instance.batchNumber,
      'expiryDate': const CustomDateTimeConverter().toJson(instance.expiryDate),
      'textKitId': instance.textKitId,
      'testKitName': instance.testKitName,
    };
