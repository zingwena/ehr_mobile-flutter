import 'package:json_annotation/json_annotation.dart';
import 'base_code.dart';

part 'occupation.g.dart';

@JsonSerializable()
class Occupation extends BaseCode{

  Occupation(int id,String name,String code){
    this.id = id;
    this.name = name;
    this.code = code;
  }

  factory Occupation.fromJson(Map<String,dynamic> json) => _$OccupationFromJson(json);

  Map<String, dynamic> toJson() => _$OccupationToJson(this);
}