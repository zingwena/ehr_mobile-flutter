import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'marital_status.g.dart';

@JsonSerializable()
class MaritalStatus extends BaseCode{
  MaritalStatus(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory MaritalStatus.fromJson(Map<String, dynamic> json) => _$MaritalStatusFromJson(json);

  Map<String, dynamic> toJson() => _$MaritalStatusToJson(this);


  static mapFromJson(List dynamicList){
    List<MaritalStatus> maritalStatusList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        MaritalStatus nationality= MaritalStatus.fromJson(e);
        maritalStatusList.add(nationality);
      });
    }
    return maritalStatusList;
  }

}