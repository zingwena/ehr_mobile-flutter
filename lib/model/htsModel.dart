
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'htsModel.g.dart';

@JsonSerializable()
class HtsModel extends BaseCode{
HtsModel(String name,String code){
    this.name = name;
    this.code = code;
  }


  factory HtsModel.fromJson(Map<String,dynamic> json) => _$HtsModelFromJson(json);

  Map<String,dynamic> toJson() => _$HtsModelToJson(this);

  static mapFromJson(List dynamicList){
    List<HtsModel> htsModelList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        HtsModel htsModel= HtsModel.fromJson(e);
        htsModelList.add(htsModel);
      });
    }
    return htsModelList;
  }



}