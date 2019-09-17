import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:json_annotation/json_annotation.dart';

import 'purposeOfTest.dart';
import 'htsModel.dart';


part 'preTest.g.dart';

@JsonSerializable(explicitToJson: true)
class PreTest {
  String htsId;
  String htsApproach;
  HtsModel htsModel;
  String newTest;
  String coupleCounselling;
  bool preTestInformationGiven;
  String optOutOfTest;
  String newTestPregLact;
  HtsModel htsModel;
  PurposeOfTest purposeOfTest;
  ReasonForNotIssuingResult reasonForNotIssuingResult;


  PreTest(this.htsId, this.htsApproach, this.htsModel, this.newTest,
      this.coupleCounselling, this.preTestInformationGiven, this.optOutOfTest,
      this.newTestPregLact, this.purposeOfTest, this.reasonForNotIssuingResult);

  factory PreTest.fromJson(Map<String, dynamic> json) => _$PreTestFromJson(json);

  Map<String, dynamic> toJson() => _$PreTestToJson(this);

  static mapFromJson(List dynamicList) {
    List<PreTest> preTestList = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        PreTest preTest = PreTest.fromJson(e);
        preTestList.add(preTest);
      });
    }
    return preTestList;
  }


}
