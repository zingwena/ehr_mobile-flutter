
import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'art_result.g.dart';
@JsonSerializable()
class ArtResult extends BaseCode{
  ArtResult(String name,String code){
    this.name = name;
    this.code = code;
  }


  factory ArtResult.fromJson(Map<String,dynamic> json) => _$ArtResultFromJson(json);

  Map<String,dynamic> toJson() => _$ArtResultToJson(this);

  static mapFromJson(List dynamicList){
    List<ArtResult> artResultList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArtResult artResult= ArtResult.fromJson(e);
        artResultList.add(artResult);
      });
    }
    return artResultList;
  }



}