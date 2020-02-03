import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'artvisitstatus.g.dart';
@JsonSerializable()
class ArtVisitStatus extends BaseCode{

  ArtVisitStatus(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory ArtVisitStatus.fromJson(Map<String,dynamic> json) => _$ArtVisitStatusFromJson(json);

  Map<String,dynamic> toJson() => _$ArtVisitStatusToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtVisitStatus> artReasonList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtVisitStatus artReason= ArtVisitStatus.fromJson(e);
        artReasonList.add(artReason);
      });
    }
    return artReasonList;
  }



}