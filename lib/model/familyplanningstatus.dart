import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'familyplanningstatus.g.dart';
@JsonSerializable()
class FamilyPlanningStatus extends BaseCode{

  FamilyPlanningStatus(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory FamilyPlanningStatus.fromJson(Map<String,dynamic> json) => _$FamilyPlanningStatusFromJson(json);

  Map<String,dynamic> toJson() => _$FamilyPlanningStatusToJson(this);

  static mapFromJson(List dynamicList){
    List<FamilyPlanningStatus> familyplanningList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        FamilyPlanningStatus familyPlanningStatus= FamilyPlanningStatus.fromJson(e);
        familyplanningList.add(familyPlanningStatus);
      });
    }
    return familyplanningList;
  }



}