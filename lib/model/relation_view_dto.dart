import 'package:ehr_mobile/model/person.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relation_view_dto.g.dart';
@JsonSerializable()
class RelationshipViewDto{
  String personId;
  String firstName;
  String lastName;
  String relation;

  RelationshipViewDto(String personId, String firstName, String lastName, String relation){
    this.personId = personId;
    this.firstName = firstName;
    this.lastName = lastName;
    this.relation = relation;
  }

  factory RelationshipViewDto.fromJson(Map<String, dynamic> json) =>_$RelationshipViewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RelationshipViewDtoToJson(this);

  static List<RelationshipViewDto> mapFromJson(List dynamicList){
    List<RelationshipViewDto> relationshipList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        RelationshipViewDto relationship=  RelationshipViewDto.fromJson(e);
        relationshipList.add(relationship);
      });
    }
    return relationshipList;
  }
}