
import 'package:ehr_mobile/db/tables/hts/hts_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_contact_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_test_table.dart';
import 'package:ehr_mobile/db/tables/laboratory_investigation_table.dart';
import 'package:ehr_mobile/db/tables/person_investigation_table.dart';
import 'package:ehr_mobile/db/tables/sexual_history_question_table.dart';
import 'package:ehr_mobile/db/tables/sexual_history_table.dart';
import 'package:ehr_mobile/db/tables/visit_table.dart';
import 'package:ehr_mobile/model/laboratory_investigation.dart';
import 'package:ehr_mobile/util/logger.dart';

import '../person.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PatientDto{

  Person personDto;
  HtsTable htsDto;
  IndexTestTable indexTestDto;

  List vitalDtos;
  PersonInvestigationTable personInvestigationDto;
  LaboratoryInvestigationTable laboratoryInvestigationDto;
  SexualHistoryTable sexualHistoryDto;
  VisitTable visitDto;


  Map<String, dynamic> toJson() {
    Map<String,dynamic>map=Map();
    map['personId']=visitDto.personId;
    map['patientType']=visitDto.patientType;
    map['time']=visitDto.time;
    map['discharged']=visitDto.discharged;
    map['hospitalNumber']=visitDto.hospitalNumber;
    map['code']=visitDto.code;
    map['name']=visitDto.name;
    map['patientId']=visitDto.id;

    map['personDto']=personDto.toEhrJson();

    if(htsDto!=null){
      map['htsDto']= htsDto.toJson();
      map['htsDto']['personInvestigationDto']=personInvestigationDto;
      map['htsDto']['laboratoryInvestigationDto']=laboratoryInvestigationDto;
    }

    if(indexTestDto!=null){
      map['indexTestDto']= indexTestDto.toJson();
    }

    if(sexualHistoryDto!=null){
      map['sexualHistoryDto']=sexualHistoryDto;
    }

    map['vitalDtos']=vitalDtos;

    return map;
  }
}