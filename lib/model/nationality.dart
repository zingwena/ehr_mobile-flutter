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

}