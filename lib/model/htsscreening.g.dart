// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'htsscreening.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HtsScreening _$HtsScreeningFromJson(Map<String, dynamic> json) {
  return HtsScreening(
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
    json['cd4Done'] as String,
  );
}

Map<String, dynamic> _$HtsScreeningToJson(HtsScreening instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'visitId': instance.visitId,
      'testedBefore': instance.testedBefore,
      'art': instance.art,
      'result': instance.result,
      'dateLastTested':
      const CustomDateTimeConverter().toJson(instance.dateLastTested),
      'artNumber': instance.artNumber,
      'beenOnPrep': instance.beenOnPrep,
      'prepOption': instance.prepOption,
      'viralLoadDone': instance.viralLoadDone,
      'cd4Done': instance.cd4Done,
      'dateEnrolled': const CustomDateTimeConverter().toJson(instance.dateEnrolled),
      'dateLastNegative': const CustomDateTimeConverter().toJson(instance.dateLastNegative),

    };
