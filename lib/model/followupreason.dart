import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'followupreason.g.dart';

@JsonSerializable()
class FollowUpReason extends BaseCode {

  FollowUpReason(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory FollowUpReason.fromJson(Map<String, dynamic> json) => _$FollowUpReasonFromJson(json);

  Map<String, dynamic> toJson() => _$FollowUpReasonToJson(this);

  @override
  String toString() {
    return 'FollowUpReason{code: $code, name: $name}';
  }

  static List<FollowUpReason> fromJsonDecodedMap(List dynamicList) {
    List<FollowUpReason> reasonList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        FollowUpReason reason = FollowUpReason.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }
  static mapFromJson(List dynamicList){
    List<FollowUpReason> reasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        FollowUpReason reason= FollowUpReason.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }

}