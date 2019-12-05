// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientsummarydto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

 PatientSummaryDto _$PatientSummaryDtoFromJson(Map<String, dynamic> json) {
String personId = json['personId'];
ValueDate temperature =  json['temperature'] == null ? null: ValueDate.fromJson(json['temperature'] as Map<String, dynamic>);
ValueDate bloodPressure =  json['bloodPressure'] == null ? null: ValueDate.fromJson(json['bloodPressure'] as Map<String, dynamic>);
ValueDate pulse =  json['pulse'] == null ? null: ValueDate.fromJson(json['pulse'] as Map<String, dynamic>);
ValueDate respiratoryRate =  json['respiratoryRate'] == null ? null: ValueDate.fromJson(json['respiratoryRate'] as Map<String, dynamic>);
ValueDate height =  json['height'] == null ? null: ValueDate.fromJson(json['height'] as Map<String, dynamic>);
ValueDate weight =  json['weight'] == null ? null: ValueDate.fromJson(json['weight'] as Map<String, dynamic>);
ArtDetailsDto artDetailsDto = json['artDetails'] == null ? null: ArtDetailsDto.fromJson(json['artDetails'] as Map<String, dynamic>);
//Handle investigations if present
   PatientSummaryDto patientSummaryDtoObj = PatientSummaryDto(personId, temperature, bloodPressure, pulse, respiratoryRate, height, weight,
   artDetailsDto, null);
if (json.keys.any((a) => a == 'investigations')) {
List<dynamic> dynamicList = json['investigations'];
List<InvestigationSummaryDto> investigations = new List<InvestigationSummaryDto>();
dynamicList.forEach((f) {
InvestigationSummaryDto investigationSummaryDto = InvestigationSummaryDto.fromJson(f);
investigations.add(investigationSummaryDto);
});
patientSummaryDtoObj.investigations = investigations;
}

return patientSummaryDtoObj;
}
Map<String, dynamic> _$PatientSummaryDtoToJson(
    PatientSummaryDto instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'temperature': instance.temperature,
      'bloodPressure': instance.bloodPressure,
      'pulse': instance.pulse,
      'height': instance.height,
      'weight': instance.weight,
      'artDetails': instance.artDetails,
      'investigations': instance.investigations,

    };

