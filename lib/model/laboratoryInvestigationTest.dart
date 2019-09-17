
import 'package:ehr_mobile/model/result.dart';
import 'package:json_annotation/json_annotation.dart';
part 'laboratoryInvestigationTest.g.dart';

@JsonSerializable()
class LaboratoryInvestigationTest{
   String id;
   String laboratoryInvestigationId;
   DateTime startTime;
   DateTime endTime;
   Result result;
   String visitId;


   LaboratoryInvestigationTest(this.id, this.laboratoryInvestigationId,
       this.startTime, this.endTime, this.result, this.visitId);

   factory LaboratoryInvestigationTest.fromJson(Map<String, dynamic> json) => _$LaboratoryInvestigationTestFromJson(json);


   Map<String, dynamic> toJson() => _$LaboratoryInvestigationTestToJson(this);


   @override
   String toString() {
     return 'LaboratoryInvestigationTest{id: $id, laboratoryInvestigationId: $laboratoryInvestigationId, startTime: $startTime, endTime: $endTime, result: $result, visitId: $visitId}';
   }

   List<LaboratoryInvestigationTest> fromJsonDecodedMap(List dynamicList) {
     List<LaboratoryInvestigationTest> labInvestigationList = [];

     if (dynamicList != null) {
       dynamicList.forEach((e) {
         LaboratoryInvestigationTest labInvestTest = LaboratoryInvestigationTest.fromJson(e);
         labInvestigationList.add(labInvestTest);
       });
     }


     return labInvestigationList;
   }


}