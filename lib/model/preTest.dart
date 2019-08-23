import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:json_annotation/json_annotation.dart';

import 'purposeOfTest.dart';
import 'htsModel.dart';


part 'preTest.g.dart';

@JsonSerializable(explicitToJson: true)
class PreTest {
  int id;
  String firstName;

  PreTest(this.id, this.firstName, this.lastName, this.htsApproach,
      this.newTest, this.coupleCounselling, this.preTestInfoGiven,
      this.optOutOfTest, this.newTestPregLact, this.htsModel,
      this.purposeOfTest, this.reasonForNotIssuingResult);

  String lastName;
  String htsApproach;
  String newTest;
  String coupleCounselling;
  String preTestInfoGiven;
  String optOutOfTest;
  String newTestPregLact;
  HtsModel htsModel;
  PurposeOfTest purposeOfTest;
  ReasonForNotIssuingResult reasonForNotIssuingResult;


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
