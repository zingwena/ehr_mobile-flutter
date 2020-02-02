import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'followupstatus.g.dart';

@JsonSerializable()
class FollowUpStatus extends BaseCode {

  FollowUpStatus(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory FollowUpStatus.fromJson(Map<String, dynamic> json) => _$FollowUpStatusFromJson(json);

  Map<String, dynamic> toJson() => _$FollowUpStatusToJson(this);

  @override
  String toString() {
    return 'FollowUpStatus{code: $code, name: $name}';
  }

  static List<FollowUpStatus> fromJsonDecodedMap(List dynamicList) {
    List<FollowUpStatus> reasonList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        FollowUpStatus reason = FollowUpStatus.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }
  static mapFromJson(List dynamicList){
    List<FollowUpStatus> reasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        FollowUpStatus reason= FollowUpStatus.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }

}