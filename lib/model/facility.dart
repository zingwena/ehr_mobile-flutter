
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';
part 'facility.g.dart';

@JsonSerializable()
class Facility extends BaseCode{
  Facility(String code,String name){
    this.code = code;
    this.name = name;

  }
  factory Facility.fromJson(Map<String, dynamic> json) =>_$FacilityFromJson(json);

  Map<String, dynamic> toJson() => _$FacilityToJson(this);

  static List<Facility> mapFromJson(List dynamicList){
    List<Facility> list=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Facility facility=  Facility.fromJson(e);
        list.add(facility);
      });
    }
    return list;
  }
  static List<Facility> fromJsonDecodedMap(List dynamicList) {
    List<Facility> facilityList = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        Facility facility = Facility.fromJson(e);
        facilityList.add(facility);
      });
    }
  }
}