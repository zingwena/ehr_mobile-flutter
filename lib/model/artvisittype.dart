import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'artvisittype.g.dart';
@JsonSerializable()
class ArtVisitType extends BaseCode{

  ArtVisitType(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory ArtVisitType.fromJson(Map<String,dynamic> json) => _$ArtVisitTypeFromJson(json);

  Map<String,dynamic> toJson() => _$ArtVisitTypeToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtVisitType> artvisitList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtVisitType artReason= ArtVisitType.fromJson(e);
        artvisitList.add(artReason);
      });
    }
    return artvisitList;
  }



}