import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'functionalstatus.g.dart';

@JsonSerializable()
class FunctionalStatus extends BaseCode {

  FunctionalStatus(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory FunctionalStatus.fromJson(Map<String, dynamic> json) => _$FunctionalStatusFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionalStatusToJson(this);

  @override
  String toString() {
    return 'FunctionalStatus{code: $code, name: $name}';
  }

  static List<FunctionalStatus> fromJsonDecodedMap(List dynamicList) {
    List<FunctionalStatus> reasonList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        FunctionalStatus reason = FunctionalStatus.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }
  static mapFromJson(List dynamicList){
    List<FunctionalStatus> reasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        FunctionalStatus reason= FunctionalStatus.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }

}