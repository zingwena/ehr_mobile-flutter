// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    json['name'] as String,
    json['code'] as String,
    json['type'] as String,
    json['categoryId'] as String,

  );
}



Map<String, dynamic> _$QuestionTestToJson(Question instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'type': instance.type,
      'categoryId': instance.categoryId,

    };
