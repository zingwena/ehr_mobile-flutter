import 'package:json_annotation/json_annotation.dart';

part 'relationship.g.dart';
@JsonSerializable()
class Relationship{
  String personId;
  String memberId;
  String relation;
  String typeOfContact;

  Relationship(String personId, String memberId, String relation, String typeOfContact){
    this.personId = personId;
    this.memberId = memberId;
    this.relation = relation;
    this.typeOfContact = typeOfContact;
  }


  factory Relationship.fromJson(Map<String, dynamic> json) =>_$RelationshipFromJson(json);

  Map<String, dynamic> toJson() => _$RelationshipToJson(this);

  static List<Relationship> mapFromJson(List dynamicList){
    List<Relationship> relationshipList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Relationship relationship=  Relationship.fromJson(e);
        relationshipList.add(relationship);
      });
    }
    return relationshipList;
  }
}