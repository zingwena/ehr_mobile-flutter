import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'namecode.g.dart';

@JsonSerializable()
class NameCode extends BaseCode {

  NameCode(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory NameCode.fromJson(Map<String, dynamic> json) => _$NameCodeFromJson(json);

  Map<String, dynamic> toJson() => _$NameCodeToJson(this);

  @override
  String toString() {
    return 'NameCode{code: $code, name: $name}';
  }

  static List<NameCode> fromJsonDecodedMap(List dynamicList) {
    List<NameCode> reasonList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        NameCode nameCode = NameCode.fromJson(e);
        reasonList.add(nameCode);
      });
    }
    return reasonList;
  }
  static mapFromJson(List dynamicList){
    List<NameCode> reasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        NameCode reason= NameCode.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }

}