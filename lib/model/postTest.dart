import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'postTest.g.dart';
@JsonSerializable(explicitToJson: true)
@CustomDateTimeConverter()
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


  @override
  String toString() {
    return 'PostTest{htsId: $htsId, datePostTestCounselled: $datePostTestCounselled, resultReceived: $resultReceived, reasonForNotIssuingResultId: $reasonForNotIssuingResultId, finalResult: $finalResult, consentToIndexTesting: $consentToIndexTesting, postTestCounselled: $postTestCounselled}';
  }

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
