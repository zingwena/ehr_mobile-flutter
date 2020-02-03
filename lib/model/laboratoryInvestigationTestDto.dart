
import 'package:ehr_mobile/model/result.dart';
import 'package:ehr_mobile/model/testKit.dart';
import 'package:json_annotation/json_annotation.dart';
part 'laboratoryInvestigationTestDto.g.dart';

@JsonSerializable()
class LaboratoryInvestigationTestDto{
  String id;
  String investigationId;
  String startTime;
  String endTime;
  DateTime startDate;
  DateTime endDate;
  Result result;
  String visitId;
  TestKit testkit;
  String personId;
  String batchIssueId;


  LaboratoryInvestigationTestDto(this.id, this.investigationId,
      this.startDate, this.endDate, this.result, this.visitId, this.testkit, this.startTime, this.endTime, this.personId, this.batchIssueId);

  factory LaboratoryInvestigationTestDto.fromJson(Map<String, dynamic> json) => _$LaboratoryInvestigationTestDtoFromJson(json);


  Map<String, dynamic> toJson() => _$LaboratoryInvestigationTestDtoToJson(this);

  static mapFromJson(List dynamicList){
    List<LaboratoryInvestigationTestDto> labInvestigationList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        LaboratoryInvestigationTestDto laboratoryInvestigationTest= LaboratoryInvestigationTestDto.fromJson(e);
        labInvestigationList.add(laboratoryInvestigationTest);
      });
    }
    return labInvestigationList;
  }



  @override
  String toString() {
    return 'LaboratoryInvestigationTest{id: $id, investigationId: $investigationId, startTime: $startTime, endTime: $endTime, result: $result, visitId: $visitId, testkit: $testkit}';
  }

  List<LaboratoryInvestigationTestDto> fromJsonDecodedMap(List dynamicList) {
    List<LaboratoryInvestigationTestDto> labInvestigationList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        LaboratoryInvestigationTestDto labInvestTest = LaboratoryInvestigationTestDto.fromJson(e);
        labInvestigationList.add(labInvestTest);
      });
    }


    return labInvestigationList;
  }


}