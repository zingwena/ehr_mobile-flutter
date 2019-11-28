
import 'package:ehr_mobile/model/base_code.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:json_annotation/json_annotation.dart';
part 'age.g.dart';
@JsonSerializable()
class Age {
  int years;
  int months;
  int days;
  Person person;

  Age(int  years,int months, int days, Person person){
     this.years = years;
     this.months = months;
     this.days = days;
     this.person = person;
  }

  factory Age.fromJson(Map<String,dynamic> json) => _$AgeFromJson(json);

  Map<String,dynamic> toJson() => _$AgeToJson(this);

  static mapFromJson(List dynamicList){
    List<Age> ageList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Age age= Age.fromJson(e);
        ageList.add(age);
      });
    }
    return ageList;
  }



}