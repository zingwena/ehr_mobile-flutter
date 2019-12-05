import 'package:json_annotation/json_annotation.dart';
part 'testingplan.g.dart';

@JsonSerializable()
class TestingPlan{
   String id;
   String name;

   TestingPlan(this.id, this.name);
   factory TestingPlan.fromJson(Map<String, dynamic> json) =>_$TestingPlanFromJson(json);
   Map<String, dynamic> toJson() => _$TestingPlanToJson(this);
   static List<TestingPlan> mapFromJson(List dynamicList){
     List<TestingPlan> testingPlanMethodList=[];
     if(dynamicList!=null){
       dynamicList.forEach((e){
         TestingPlan testingPlan=  TestingPlan.fromJson(e);
         testingPlanMethodList.add(testingPlan);
       });
     }
     return testingPlanMethodList;
   }
}