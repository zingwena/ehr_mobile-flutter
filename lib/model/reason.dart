import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'reason.g.dart';

@JsonSerializable()
class Reason extends BaseCode {

  Reason(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory Reason.fromJson(Map<String, dynamic> json) => _$ReasonFromJson(json);

  Map<String, dynamic> toJson() => _$ReasonToJson(this);

  @override
  String toString() {
    return 'Reason{code: $code, name: $name}';
  }

  static List<Reason> fromJsonDecodedMap(List dynamicList) {
    List<Reason> reasonList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        Reason reason = Reason.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }
  static mapFromJson(List dynamicList){
    List<Reason> reasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Reason reason= Reason.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }

}