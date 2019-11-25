import 'package:ehr_mobile/model/person.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RelationshipViewDto{
  Person person;

  String relation;

  RelationshipViewDto(Person person,String relation){
    this.person = person;
    this.relation = relation;
  }

/*  factory RelationshipViewDto.fromJson(Map<String, dynamic> json) =>_$RelationshipFromJson(json);

  Map<String, dynamic> toJson() => _$ReligionToJson(this);

  static List<RelationshipViewDto> mapFromJson(List dynamicList){
    List<RelationshipViewDto> relationshipList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        RelationshipViewDto relationship=  RelationshipViewDto.fromJson(e);
        relationshipList.add(relationship);
      });
    }
    return relationshipList;
  }*/
}