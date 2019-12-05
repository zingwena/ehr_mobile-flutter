// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sexualhistoryview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SexualHistoryView _$SexualHistoryViewFromJson(Map<String, dynamic> json) {
  return SexualHistoryView(
    json['id'] as String,
    json['question'] == null
        ? null
        : Response.fromJson(json['question'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SexualHistoryViewToJson(SexualHistoryView instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
    };
