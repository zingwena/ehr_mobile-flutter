
import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'entry_point.g.dart';
@JsonSerializable()
class EntryPoint extends BaseCode{
  EntryPoint(int id,String name,String code){
    this.id = id;
    this.name = name;
    this.code = code;
  }


  factory EntryPoint.fromJson(Map<String,dynamic> json) => _$EntryPointFromJson(json);

  Map<String,dynamic> toJson() => _$EntryPointToJson(this);

  static mapFromJson(List dynamicList){
    List<EntryPoint> entryPointList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        EntryPoint entryPoint= EntryPoint.fromJson(e);
        entryPointList.add(entryPoint);
      });
    }
    return entryPointList;
  }



}