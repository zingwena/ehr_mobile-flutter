import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:json_annotation/json_annotation.dart';



part 'postTest.g.dart';

@JsonSerializable(explicitToJson: true)
class PostTest {
  int id;
  String firstName;
  DateTime dateOfPostTestCounsel;
  String resultReceived;
  String finalResult;

  PostTest(this.id, this.firstName, this.lastName, this.reasonForNotIssuingResult,this.dateOfPostTestCounsel,this.finalResult,this.resultReceived);

  String lastName;

  ReasonForNotIssuingResult reasonForNotIssuingResult;


  factory PostTest.fromJson(Map<String, dynamic> json) => _$PostTestFromJson(json);



  Map<String, dynamic> toJson() => _$PostTestToJson(this);

  static mapFromJson(List dynamicList) {
    List<PostTest> postTestList = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        PostTest postTest = PostTest.fromJson(e);
        postTestList.add(postTest);
      });
    }
    return postTestList;
  }


}
