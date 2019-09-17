
import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'town.g.dart';

@JsonSerializable()
class Town extends BaseCode{

  Town(String name, String code){
    this.name=name;
    this.code=code;
  }

  factory Town.fromJson(Map<String, dynamic> json)=>_$TownFromJson(json);

      Map<String, dynamic> toJson() => _$TownToJson(this);


      static List<Town> mapFromJson(List dynamicList){
    List<Town> townList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Town town=  Town.fromJson(e);
        townList.add(town);
      });
    }
    return townList;
  }
}