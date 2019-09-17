
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';
part 'testKit.g.dart';

@JsonSerializable()
class TestKit extends BaseCode{
  String description; String level;
  TestKit(String code,String name, String description, String level){
    this.code = code;
    this.name = name;
    this.description = description;
    this.level=level;
  }
  factory TestKit.fromJson(Map<String, dynamic> json) =>_$TestKitFromJson(json);

  Map<String, dynamic> toJson() => _$TestKitToJson(this);

static List<TestKit> mapFromJson(List dynamicList){
  List<TestKit> list=[];
  if(dynamicList!=null){
    dynamicList.forEach((e){
      TestKit testKit=  TestKit.fromJson(e);
      list.add(testKit);
    });
  }
  return list;
}




}