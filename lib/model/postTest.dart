import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:json_annotation/json_annotation.dart';



part 'postTest.g.dart';

@JsonSerializable(explicitToJson: true)
class PostTest {
  String htsId;
  DateTime datePostTestCounselled;
  bool resultReceived;
  String reasonForNotIssuingResultId;
  String finalResult;
  bool consentToIndexTesting;
  bool postTestCounselled;

  PostTest(this.htsId, this.datePostTestCounselled,this.resultReceived,this.reasonForNotIssuingResultId, this.finalResult, this.consentToIndexTesting, this.postTestCounselled);

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
