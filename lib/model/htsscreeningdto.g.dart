// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'htsscreeningdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HtsScreeningdto _$HtsScreeningFromJson(Map<String, dynamic> json) {
  return HtsScreeningdto(
    json['personId'] as String,
    json['visitId'] as String,
    json['testedBefore'] as bool,
    json['art'] as bool,
    json['result'] as String,
    const CustomDateTimeConverter().fromJson(json['dateLastNegative'] as String),
    const CustomDateTimeConverter().fromJson(json['dateLastTested'] as String),
    const CustomDateTimeConverter().fromJson(json['dateEnrolled'] as String),
    json['artNumber'] as String,
    json['beenOnPrep'] as bool,
    json['prepOption'] as String,
    json['viralLoadDone'] as String,
    const CustomDateTimeConverter().fromJson(json['viralLoadDate'] as String),
    json['cd4Done'] as String,
    const CustomDateTimeConverter().fromJson(json['cd4CountDate'] as String),
  );
}

Map<String, dynamic> _$HtsScreeningToJson(HtsScreeningdto  instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'visitId': instance.visitId,
      'testedBefore': instance.testedBefore,
      'art': instance.art,
      'result': instance.result,
      'dateLastNegative': const CustomDateTimeConverter().toJson(instance.dateLastNegative),
      'dateLastTested': const CustomDateTimeConverter().toJson(instance.dateLastTested),
      'dateEnrolled': const CustomDateTimeConverter().toJson(instance.dateEnrolled),
      'artNumber': instance.artNumber,
      'beenOnPrep': instance.beenOnPrep,
      'prepOption': instance.prepOption,
      'viralLoadDone': instance.viralLoadDone,
      'cd4Done': instance.cd4Done,
      'viralLoadDate': const CustomDateTimeConverter().toJson(instance.viralLoadDate),
      'cd4CountDate': const CustomDateTimeConverter().toJson(instance.cd4CountDate),

    };
