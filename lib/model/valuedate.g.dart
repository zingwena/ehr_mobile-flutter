// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valuedate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueDate _$ValueDateFromJson(Map<String, dynamic> json) {
  return ValueDate(
    json['value'] as double,
    const CustomDateTimeConverter().fromJson(json['date'] as String),

  );
}

Map<String, dynamic> _$ValueDateToJson(ValueDate instance) => <String, dynamic>{
      'value': instance.value,
      'date': const CustomDateTimeConverter().toJson(instance.date),
    };
