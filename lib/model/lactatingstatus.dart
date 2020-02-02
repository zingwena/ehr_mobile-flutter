import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'lactatingstatus.g.dart';

@JsonSerializable()
class LactatingStatus extends BaseCode {

  LactatingStatus(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory LactatingStatus.fromJson(Map<String, dynamic> json) => _$LactatingStatusFromJson(json);

  Map<String, dynamic> toJson() => _$LactatingStatusToJson(this);

  @override
  String toString() {
    return 'LactatingStatus{code: $code, name: $name}';
  }

  static List<LactatingStatus> fromJsonDecodedMap(List dynamicList) {
    List<LactatingStatus> reasonList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        LactatingStatus reason = LactatingStatus.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }
  static mapFromJson(List dynamicList){
    List<LactatingStatus> reasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        LactatingStatus reason= LactatingStatus.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }

}