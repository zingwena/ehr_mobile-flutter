// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbscreening.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TbScreening _$TbScreeningFromJson(Map<String, dynamic> json) {
  return TbScreening(
    json['visitId'] as String,
    json['presumptive'] as bool,
    json['note'] as String,
    const CustomDateTimeConverter().fromJson(json['time'] as String),
    json['fever'] as bool,
    json['coughing'] as bool,
    json['weightLoss'] as bool,
    json['nightSweats'] as bool,
    json['bmiUnderSeventeen'] as bool,

  );
}

Map<String, dynamic> _$TbScreeningToJson(TbScreening instance) =>
    <String, dynamic>{
      'visitId': instance.visitId,
      'presumptive': instance.name,
      'note': instance.note,
      'time': const CustomDateTimeConverter().toJson(instance.time),
      'fever': instance.fever,
      'coughing': instance.coughing,
      'weightLoss': instance.weightLoss,
      'nightSweats': instance.nightSweats,
      'bmiUnderSeventeen': instance.bmiUnderSeventeen,


    };





