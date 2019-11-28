
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';
part 'response.g.dart';

@JsonSerializable()
class Response extends BaseCode{
  String responseType;
  Response(String code,String name, String responseType){
    this.code = code;
    this.name = name;
    this.responseType = responseType;
  }
  factory Response.fromJson(Map<String, dynamic> json) =>_$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);

  static List<Response> mapFromJson(List dynamicList){
    List<Response> list=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Response response=  Response.fromJson(e);
        list.add(response);
      });
    }
    return list;
  }
  static List<Response> fromJsonDecodedMap(List dynamicList) {
    List<Response> responseList = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        Response response = Response.fromJson(e);
        responseList.add(response);
      });
    }
  }
}