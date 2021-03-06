import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'education_level.g.dart';

@JsonSerializable()
class EducationLevel extends BaseCode {
  EducationLevel(String name, String code) {
    this.name = name;
    this.code = code;
  }

  factory EducationLevel.fromJson(Map<String, dynamic> json) =>
      _$EducationLevelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationLevelToJson(this);

  static mapFromJson(List dynamicList){
    List<EducationLevel> educationLevelList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        EducationLevel nationality= EducationLevel.fromJson(e);
        educationLevelList.add(nationality);
      });
    }
    return educationLevelList;
  }

}
