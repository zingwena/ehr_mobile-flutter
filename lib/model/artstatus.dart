import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'artstatus.g.dart';
@JsonSerializable()
class ArtStatus extends BaseCode{

  ArtStatus(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory ArtStatus.fromJson(Map<String,dynamic> json) => _$ArtStatusFromJson(json);

  Map<String,dynamic> toJson() => _$ArtStatusToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtStatus> artReasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtStatus artReason= ArtStatus.fromJson(e);
        artReasonList.add(artReason);
      });
    }
    return artReasonList;
  }



}