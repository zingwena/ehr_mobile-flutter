// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testkitbatchissue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestKitBatchIssue _$TestKitBatchIssueFromJson(Map<String, dynamic> json) {
  return TestKitBatchIssue(
    json['id'] as String,
    (json['remaining'] as num)?.toDouble(),
    json['statusAccepted'] as bool,
    json['expiredStatus'] as bool,
    json['batch'] == null
        ? null
        : Batch.fromJson(json['batch'] as Map<String, dynamic>),
    json['detail'] == null
        ? null
        : BinTypeIdName.fromJson(json['detail'] as Map<String, dynamic>),
    (json['quantity'] as num)?.toDouble(),
    const CustomDateTimeConverter().fromJson(json['date'] as String),
  );
}

Map<String, dynamic> _$TestKitBatchIssueToJson(TestKitBatchIssue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remaining': instance.remaining,
      'statusAccepted': instance.statusAccepted,
      'expiredStatus': instance.expiredStatus,
      'batch': instance.batch?.toJson(),
      'detail': instance.detail?.toJson(),
      'quantity': instance.quantity,
      'date': const CustomDateTimeConverter().toJson(instance.date),
    };
