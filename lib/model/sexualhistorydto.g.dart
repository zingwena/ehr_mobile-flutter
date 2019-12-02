// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sexualhistorydto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SexualHistoryDto _$SexualHistoryDtoFromJson(Map<String, dynamic> json) {
  return SexualHistoryDto(
    json['personId'] as String,
    json['sexualHistoryId'] as String,
    json['question'] == null ? null: Response.fromJson(json['question'] as Map<String, dynamic>),
  );

}

Map<String, dynamic> _$SexualHistoryDtoToJson(SexualHistoryDto instance) => <String, dynamic>{
  'personId': instance.personId,
  'sexualHistoryId': instance.sexualHistoryId,
  'question': instance.question,
};
