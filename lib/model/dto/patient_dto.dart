
import 'dart:convert';

import 'package:ehr_mobile/db/tables/hts_table.dart';

import '../person.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PatientDto{
  Person personDto;
  HtsTable htsDto;
  List vitalDtos;
  Map<String, dynamic> toJson() {
    Map<String,dynamic>map=Map();
    map['personDto']=personDto.toEhrJson();
    if(htsDto!=null){
      map['htsDto']= htsDto.toJson();
    }
    map['vitalDtos']=vitalDtos;
    return map;
  }
}