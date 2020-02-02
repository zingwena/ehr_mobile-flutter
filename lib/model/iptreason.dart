import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'iptreason.g.dart';

@JsonSerializable()
class IptReason extends BaseCode {

  IptReason(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory IptReason.fromJson(Map<String, dynamic> json) => _$IptReasonFromJson(json);

  Map<String, dynamic> toJson() => _$IptReasonToJson(this);

  @override
  String toString() {
    return 'IptReason{code: $code, name: $name}';
  }

  static List<IptReason> fromJsonDecodedMap(List dynamicList) {
    List<IptReason> reasonList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        IptReason reason = IptReason.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }
  static mapFromJson(List dynamicList){
    List<IptReason> reasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        IptReason reason= IptReason.fromJson(e);
        reasonList.add(reason);
      });
    }
    return reasonList;
  }

}