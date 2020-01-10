
import 'package:ehr_mobile/db/tables/hts/hts_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_contact_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_test_table.dart';
import 'package:ehr_mobile/db/tables/laboratory_investigation_table.dart';
import 'package:ehr_mobile/db/tables/person_investigation_table.dart';
import 'package:ehr_mobile/model/laboratory_investigation.dart';
import 'package:ehr_mobile/util/logger.dart';

import '../person.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PatientDto{
  Person personDto;
  HtsTable htsDto;
  IndexTestTable indexTestDto;
  List<IndexContactTable> indexContactDtos;
  List vitalDtos;
  List<PersonInvestigationTable> personInvestigationDtos=List();
  LaboratoryInvestigationTable laboratoryInvestigationDto;
  //List<>
  Map<String, dynamic> toJson() {
    Map<String,dynamic>map=Map();
    map['personDto']=personDto.toEhrJson();

    if(htsDto!=null){
      htsDto.personInvestigationDtos=personInvestigationDtos;
      map['htsDto']= htsDto.toJson();
      map['htsDto']['personInvestigationDtos']=personInvestigationDtos;
      map['htsDto']['laboratoryInvestigationDto']=laboratoryInvestigationDto;
    }

    if(indexTestDto!=null){
      map['indexTestDto']= indexTestDto.toJson();
    }
    map['vitalDtos']=vitalDtos;
    map['indexContactDtos']=indexContactDtos;

    return map;
  }
}