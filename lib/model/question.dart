import 'package:json_annotation/json_annotation.dart';
part 'question.g.dart';

@JsonSerializable()
class Question{
  String name;
  String code;
  String type;
  String categoryId;

  Question(this.code, this.name, this.type, this.categoryId);

  factory Question.fromJson(Map<String, dynamic> json) =>_$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionTestToJson(this);

  static List<Question> mapFromJson(List dynamicList){
    List<Question> testingPlanMethodList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Question testingPlan=  Question.fromJson(e);
        testingPlanMethodList.add(testingPlan);
      });
    }
    return testingPlanMethodList;
  }
}