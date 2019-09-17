
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'occupation.g.dart';

@JsonSerializable()
class Occupation extends BaseCode{

  Occupation(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory Occupation.fromJson(Map<String,dynamic> json) => _$OccupationFromJson(json);

  Map<String, dynamic> toJson() => _$OccupationToJson(this);


  static mapFromJson(List dynamicList){
    List<Occupation> occupationList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Occupation nationality= Occupation.fromJson(e);
        occupationList.add(nationality);
      });
    }
    return occupationList;
  }

}