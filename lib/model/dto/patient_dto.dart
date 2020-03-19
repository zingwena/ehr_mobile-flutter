
import 'package:ehr_mobile/db/tables/art/ArtAppointmentTable.dart';
import 'package:ehr_mobile/db/tables/art/ArtCurrentStatusTable.dart';
import 'package:ehr_mobile/db/tables/art/ArtIptTable.dart';
import 'package:ehr_mobile/db/tables/art/ArtLinkageForm.dart';
import 'package:ehr_mobile/db/tables/art/ArtOI.dart';
import 'package:ehr_mobile/db/tables/art/ArtSymptomTable.dart';
import 'package:ehr_mobile/db/tables/art_initiation_table.dart';
import 'package:ehr_mobile/db/tables/art_table.dart';
import 'package:ehr_mobile/db/tables/hts/hts_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_test_table.dart';
import 'package:ehr_mobile/db/tables/hts_screening_table.dart';
import 'package:ehr_mobile/db/tables/person_investigation_table.dart';
import 'package:ehr_mobile/db/tables/person_table.dart';
import 'package:ehr_mobile/db/tables/sexual_history_table.dart';
import 'package:ehr_mobile/model/artsymptom.dart';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PatientDto{

  PersonTable personDto;
  HtsTable htsDto;
  IndexTestTable indexTestDto;
  List vitalDtos;
  List<PersonInvestigationTable> personInvestigationDtos=List();
  SexualHistoryTable sexualHistoryDto;
  HtsScreeningTable htsScreeningDto;
  ArtCurrentStatusTable artCurrentStatusDto;
  ArtTable artDto;
  ArtAppointmentTable artAppointmentDto;
  ArtIptTable artIptDto;
  ArtSymptomTable artSymptomDto;
  ArtLinkageFormTable artLinkageFromDto;
  ArtOITable artOIDto;


  String personId;
  String patientType;
  String time;
  String discharged;
  String hospitalNumber;
  String code;
  String name;
  String patientId;


  Map<String, dynamic> toJson() {
    Map<String,dynamic>map=Map();
    map['personId']=personId;
    map['patientType']=patientType;
    map['time']=time;
    map['discharged']=discharged;
    map['hospitalNumber']=hospitalNumber;
    map['code']=code;
    map['name']=name;
    map['patientId']=patientId;
    map['personDto']=personDto.toEhrJson();

    if(htsDto!=null){
      map['htsDto']= htsDto.toJson();
    }

    if(indexTestDto!=null){
      map['indexTestDto']= indexTestDto.toJson();
    }

    if(sexualHistoryDto!=null){
      map['sexualHistoryDto']=sexualHistoryDto;
    }
    if(htsScreeningDto!=null){
      map['htsScreeningDto']=htsScreeningDto;
    }
    if(artDto!=null){
      map['artDto']=artDto;
    }
    if(artCurrentStatusDto!=null){
      map['artCurrentStatusDto']=artCurrentStatusDto;
    }
    if(artAppointmentDto!=null){
      map['artAppointmentDto']=artAppointmentDto;
    }
    if(artIptDto!=null){
      map['artIptDto']=artIptDto;
    }
    if(artSymptomDto!=null){
      map['artSymptomDto']=artSymptomDto;
    }
    if(artLinkageFromDto!=null){
      map['artLinkageFromDto']=artLinkageFromDto;
    }
    if(artOIDto!=null){
      map['artOIDto']=artOIDto;
    }
    if(personInvestigationDtos!=null){
      map['personInvestigationDtos']=personInvestigationDtos;
    }
    map['vitalDtos']=vitalDtos;

    return map;
  }

  @override
  String toString() {
    return 'PatientDto{personDto: $personDto, htsDto: $htsDto, indexTestDto: $indexTestDto, vitalDtos: $vitalDtos, personInvestigationDtos: $personInvestigationDtos, sexualHistoryDto: $sexualHistoryDto, htsScreeningDto: $htsScreeningDto, artCurrentStatusDto: $artCurrentStatusDto, artDto: $artDto, artAppointmentDto: $artAppointmentDto, artIptDto: $artIptDto, artSymptomDto: $artSymptomDto, artLinkageFromDto: $artLinkageFromDto, artOIDto: $artOIDto, personId: $personId, patientType: $patientType, time: $time, discharged: $discharged, hospitalNumber: $hospitalNumber, code: $code, name: $name, patientId: $patientId}';
  }


}