import 'package:json_annotation/json_annotation.dart';

import 'htsModel.dart';
import 'purposeOfTest.dart';

part 'preTest.g.dart';

@JsonSerializable(explicitToJson: true)
class PreTest {
  String personId;
  String htsId;
  String htsApproach;
  String htsModelId;
  bool newTestInClientLife;
  bool coupleCounselling;
  bool preTestInformationGiven;
  bool optOutOfTest;
  bool newTestPregLact;
  String reasonForHivTestingId;
  PreTest(
      this.personId,
      this.htsId,
      this.htsApproach,
      this.htsModelId,
      this.newTestInClientLife,
      this.coupleCounselling,
      this.preTestInformationGiven,
      this.optOutOfTest,
      this.newTestPregLact,
      this.reasonForHivTestingId);

  factory PreTest.fromJson(Map<String, dynamic> json) =>
      _$PreTestFromJson(json);


  @override
  String toString() {
    return 'PreTest{personId: $personId, htsId: $htsId, htsApproach: $htsApproach, htsModelId: $htsModelId, newTestInClientLife: $newTestInClientLife, coupleCounselling: $coupleCounselling, preTestInformationGiven: $preTestInformationGiven, optOutOfTest: $optOutOfTest, newTestPregLact: $newTestPregLact, reasonForHivTestingId: $reasonForHivTestingId}';
  }

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
