import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'iptstatus.g.dart';

@JsonSerializable()
class IptStatus extends BaseCode {

  IptStatus(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory IptStatus.fromJson(Map<String, dynamic> json) => _$IptStatusFromJson(json);

  Map<String, dynamic> toJson() => _$IptStatusToJson(this);

  @override
  String toString() {
    return 'IptStatus{code: $code, name: $name}';
  }

  static List<IptStatus> fromJsonDecodedMap(List dynamicList) {
    List<IptStatus> reasonList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        IptStatus reason = IptStatus.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }
  static mapFromJson(List dynamicList){
    List<IptStatus> reasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        IptStatus reason= IptStatus.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }

}