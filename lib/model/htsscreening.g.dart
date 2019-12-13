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
    json['dateLastNegative'] == null
        ? null
        : DateTime.parse(json['dateLastNegative'] as String),
    json['dateLastTested'] == null
        ? null
        : DateTime.parse(json['dateLastTested'] as String),
    json['dateEnrolled'] == null
        ? null
        : DateTime.parse(json['dateEnrolled'] as String),
    json['artNumber'] as String,
    json['beenOnPrep'] as bool,
    json['prepOption'] as String,
    json['viralLoadDone'] as String,
    json['viralLoadDate'] == null
        ? null
        : DateTime.parse(json['viralLoadDate'] as String),
    json['cd4Done'] as String,
    json['cd4CountDate'] == null
        ? null
        : DateTime.parse(json['cd4CountDate'] as String),
  );
}

Map<String, dynamic> _$HtsScreeningToJson(HtsScreening instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'visitId': instance.visitId,
      'testedBefore': instance.testedBefore,
      'art': instance.art,
      'result': instance.result,
      'dateLastTested': instance.dateLastTested?.toIso8601String(),
      'artNumber': instance.artNumber,
      'beenOnPrep': instance.beenOnPrep,
      'prepOption': instance.prepOption,
      'viralLoadDone': instance.viralLoadDone,
      'cd4Done': instance.cd4Done,
      'dateEnrolled': instance.dateEnrolled?.toIso8601String(),
      'dateLastNegative': instance.dateLastNegative?.toIso8601String(),
      'viralLoadDate': instance.viralLoadDate?.toIso8601String(),
      'cd4CountDate': instance.cd4CountDate?.toIso8601String(),
    };
