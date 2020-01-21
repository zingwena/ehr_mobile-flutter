
import 'package:ehr_mobile/db/tables/art_table.dart';
import 'package:ehr_mobile/db/tables/hts/hts_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_test_table.dart';
import 'package:ehr_mobile/db/tables/hts_screening_table.dart';
import 'package:ehr_mobile/db/tables/person_investigation_table.dart';
import 'package:ehr_mobile/db/tables/sexual_history_table.dart';

import '../person.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PatientDto{

  Person personDto;
  HtsTable htsDto;
  IndexTestTable indexTestDto;

  List vitalDtos;
  List<PersonInvestigationTable> personInvestigationDtos=List();
  SexualHistoryTable sexualHistoryDto;
  HtsScreeningTable htsScreeningDto;

  String personId;
  int patientType;
  String time;
  String discharged;
  String hospitalNumber;
  String code;
  String name;
  String patientId;

  ArtTable artDto;

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

    if(personInvestigationDtos!=null){
      map['personInvestigationDtos']=personInvestigationDtos;
    }
    map['vitalDtos']=vitalDtos;

    return map;
  }
}