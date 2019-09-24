
import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'art_reason.g.dart';
@JsonSerializable()
class ArtReason extends BaseCode{
  ArtReason(String name,String code){
    this.name = name;
    this.code = code;
  }


  factory ArtReason.fromJson(Map<String,dynamic> json) => _$ArtReasonFromJson(json);

  Map<String,dynamic> toJson() => _$ArtReasonToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtReason> artReasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtReason artReason= ArtReason.fromJson(e);
        artReasonList.add(artReason);
      });
    }
    return artReasonList;
  }



}