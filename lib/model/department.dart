
import 'package:json_annotation/json_annotation.dart';
import 'base_code.dart';
part 'department.g.dart';

@JsonSerializable()
class Department extends BaseCode{
  Department(String code,String name){
    this.code = code;
    this.name = name;

  }
  factory Department.fromJson(Map<String, dynamic> json) =>_$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);

  static List<Department> mapFromJson(List dynamicList){
    List<Department> list=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Department department=  Department.fromJson(e);
        list.add(department);
      });
    }
    return list;
  }
  static List<Department> fromJsonDecodedMap(List dynamicList) {
    List<Department> departmetList = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        Department department = Department.fromJson(e);
        departmetList.add(department);
      });
    }
  }
}