
import 'package:json_annotation/json_annotation.dart';

import 'base_code.dart';

part 'purposeOfTest.g.dart';

@JsonSerializable()
class PurposeOfTest extends BaseCode{
  PurposeOfTest(int id,String name,String code){
    this.id = id;
    this.name = name;
    this.code = code;
  }


  factory PurposeOfTest.fromJson(Map<String,dynamic> json) => _$PurposeOfTestFromJson(json);

  Map<String,dynamic> toJson() => _$PurposeOfTestToJson(this);

  static mapFromJson(List dynamicList) {
      List<PurposeOfTest> purposeOfTestList = [];
      if (dynamicList != null) {
        dynamicList.forEach((e) {
          PurposeOfTest purposeOfTest = PurposeOfTest.fromJson(e);
          purposeOfTestList.add(purposeOfTest);
        });
      }
      return purposeOfTestList;
    }
  }