// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valuedate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueDate _$ValueDateFromJson(Map<String, dynamic> json) {
  return ValueDate(
    json['value'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),

  );
}

Map<String, dynamic> _$ValueDateToJson(ValueDate instance) => <String, dynamic>{
  'value': instance.value,
  'date': instance.date,
};
