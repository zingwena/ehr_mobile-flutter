import 'package:ehr_mobile/model/artdetailsdto.dart';
import 'package:ehr_mobile/model/investigationsummarydto.dart';
import 'package:ehr_mobile/model/valuedate.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part'patientsummarydto.g.dart';

@JsonSerializable()
class PatientSummaryDto{
   String personId;
   ValueDate temperature;
   ValueDate bloodPressure;
   ValueDate pulse;
   ValueDate respiratoryRate;
   ValueDate height;
   ValueDate weight;
   ArtDetailsDto artDetails;
   List<InvestigationSummaryDto> investigations = List();

  PatientSummaryDto(String personId, ValueDate temperature, ValueDate bloodPressure, ValueDate pulse,
      ValueDate respiratoryRate, ValueDate height, ValueDate weight, ArtDetailsDto artDetails,  List<InvestigationSummaryDto> investigations){

    this.personId = personId;
    this.temperature = temperature;
    this.bloodPressure = bloodPressure;
    this.pulse = pulse;
    this.respiratoryRate = respiratoryRate;
    this.height = height;
    this.weight = weight;
    this.artDetails = artDetails;
    this.investigations = investigations;
  }

  factory PatientSummaryDto.fromJson(Map<String,dynamic> json) => _$PatientSummaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PatientSummaryDtoToJson(this);


  static mapFromJson(List dynamicList){
    List<PatientSummaryDto> patientSummaryList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        PatientSummaryDto patientSummaryDto= PatientSummaryDto.fromJson(e);
        patientSummaryList.add(patientSummaryDto);
      });
    }
    return patientSummaryList;
  }

}