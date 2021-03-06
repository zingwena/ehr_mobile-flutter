import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'result.g.dart';

@JsonSerializable()
class Result extends BaseCode {

Result(String name,String code){
    this.name = name;
    this.code = code;
  }

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  String toString() {
    return 'Result{code: $code, name: $name}';
  }

  static List<Result> fromJsonDecodedMap(List dynamicList) {
    List<Result> resultList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        Result result = Result.fromJson(e);
        resultList.add(result);
      });
    }


    return resultList;
  }
static mapFromJson(List dynamicList){
  List<Result> resultList=[];
  if(dynamicList!=null){
    dynamicList.forEach((e){
      Result result= Result.fromJson(e);
      resultList.add(result);
    });
  }
  return resultList;
}

}