
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';
part 'religion.g.dart';

@JsonSerializable()
class Religion extends BaseCode{
  Religion(String name,String code){
    this.name = name;
    this.code = code;
  }
  factory Religion.fromJson(Map<String, dynamic> json) =>_$ReligionFromJson(json);

  Map<String, dynamic> toJson() => _$ReligionToJson(this);

static List<Religion> mapFromJson(List dynamicList){
  List<Religion> religionList=[];
  if(dynamicList!=null){
    dynamicList.forEach((e){
      Religion religion=  Religion.fromJson(e);
      religionList.add(religion);
    });
  }
  return religionList;
}




}