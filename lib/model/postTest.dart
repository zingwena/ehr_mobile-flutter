import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:json_annotation/json_annotation.dart';



part 'postTest.g.dart';

@JsonSerializable(explicitToJson: true)
class PostTest {
  String htsId;
  DateTime datePostTestCounselled;
  bool resultReceived;
  ReasonForNotIssuingResult reasonForNotIssuingResult;
  String finalResult;
  bool consentToIndexTesting;

  PostTest(this.htsId, this.datePostTestCounselled,this.resultReceived,this.reasonForNotIssuingResult, this.finalResult, this.consentToIndexTesting);

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
