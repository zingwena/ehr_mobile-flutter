
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'personInvestigation.g.dart';

@JsonSerializable()
class PersonInvestigation {
  String id;
  String personId;
  String investigationId;
  DateTime date;
  String resultId;


  PersonInvestigation(this.personId,
      this.investigationId, this.date, this.resultId);

  factory PersonInvestigation.fromJson(Map<String,dynamic> json) => _$PersonInvestigationFromJson(json);

  Map<String, dynamic> toJson() => _$PersonInvestigationToJson(this);


  static mapFromJson(List dynamicList){
    List<PersonInvestigation> personInvestigationList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        PersonInvestigation personInvestigation= PersonInvestigation.fromJson(e);
        personInvestigationList.add(personInvestigation);
      });
    }
    return personInvestigationList;
  }

}