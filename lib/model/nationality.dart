import 'package:json_annotation/json_annotation.dart';
import 'base_code.dart';

part 'nationality.g.dart';

@JsonSerializable()
class Nationality extends BaseCode{
  Nationality(int id,String name,String code){
    this.id = id;
    this.name = name;
    this.code = code;
  }


  factory Nationality.fromJson(Map<String,dynamic> json) => _$NationalityFromJson(json);

  Map<String,dynamic> toJson() => _$NationalityToJson(this);

  static mapFromJson(List dynamicList){
    List<Nationality> nationalityList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Nationality nationality= Nationality.fromJson(e);
        nationalityList.add(nationality);
      });
    }
    return nationalityList;
  }


}