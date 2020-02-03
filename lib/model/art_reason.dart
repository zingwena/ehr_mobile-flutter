
import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'art_reason.g.dart';
@JsonSerializable()
class ArtReason extends BaseCode{

  String artStatusId;
  ArtReason(String name,String code, String artStatusId){
    this.name = name;
    this.code = code;
    this.artStatusId = artStatusId;
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