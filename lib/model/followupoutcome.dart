import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'followupoutcome.g.dart';
@JsonSerializable()
class FollowUpOutcome extends BaseCode{

  FollowUpOutcome(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory FollowUpOutcome.fromJson(Map<String,dynamic> json) => _$FollowUpOutcomeFromJson(json);

  Map<String,dynamic> toJson() => _$FollowUpOutcomeToJson(this);

  static mapFromJson(List dynamicList){
    List<FollowUpOutcome> followUpOutcomeList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        FollowUpOutcome followUpOutcome= FollowUpOutcome.fromJson(e);
        followUpOutcomeList.add(followUpOutcome);
      });
    }
    return followUpOutcomeList;
  }



}