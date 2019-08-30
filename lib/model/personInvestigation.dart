
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'personInvestigation.g.dart';

@JsonSerializable()
class PersonInvestigation {
  int personInvestigationId;
  String patientId;
  String investigationId;
  DateTime date;
  String resultId;


  PersonInvestigation(this.personInvestigationId, this.patientId,
      this.investigationId, this.date, this.resultId);

  factory PersonInvestigation.fromJson(Map<String,dynamic> json) => _$PersonInvestigationFromJson(json);

  Map<String, dynamic> toJson() => _$PersonInvestigationToJson(this);


  static mapFromJson(List dynamicList){
    List<PersonInvestigation> PersonInvestigationList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        PersonInvestigation personInvestigation= PersonInvestigation.fromJson(e);
        PersonInvestigationList.add(personInvestigation);
      });
    }
    return PersonInvestigationList;
  }

}