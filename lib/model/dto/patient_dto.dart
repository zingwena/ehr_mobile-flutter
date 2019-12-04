
import 'package:ehr_mobile/db/tables/hts/hts_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_contact_table.dart';
import 'package:ehr_mobile/db/tables/hts/index_test_table.dart';

import '../person.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PatientDto{
  Person personDto;
  HtsTable htsDto;
  IndexTestTable indexTestDto;
  List<IndexContactTable> indexContactDtos;
  List vitalDtos;
  Map<String, dynamic> toJson() {
    Map<String,dynamic>map=Map();
    map['personDto']=personDto.toEhrJson();

    if(htsDto!=null){
      map['htsDto']= htsDto.toJson();
    }

    if(indexTestDto!=null){
      map['indexTestDto']= indexTestDto.toJson();
    }
    map['vitalDtos']=vitalDtos;
    map['indexContactDtos']=indexContactDtos;
    return map;
  }
}