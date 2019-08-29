
import 'package:ehr_mobile/model/result.dart';
import 'package:json_annotation/json_annotation.dart';
part 'laboratoryInvestigationTest.g.dart';

@JsonSerializable()
class LaboratoryInvestigationTest{
   int id;
   String laboratoryInvestigationId;
   DateTime startdate;
   DateTime starttime;
   DateTime readingdate;
   DateTime readingtime;
   Result result;
   String visitId;

   LaboratoryInvestigationTest(this.id, this.startdate, this.starttime, this.readingdate, this.readingtime,
       this.result, this.visitId);

   factory LaboratoryInvestigationTest.fromJson(Map<String, dynamic> json) => _$LaboratoryInvestigationTestFromJson(json);


   Map<String, dynamic> toJson() => _$LaboratoryInvestigationTestToJson(this);


   @override
   String toString() {
     return 'LaboratoryInvestigationTest{id: $id, laboratoryInvestigationId: $laboratoryInvestigationId, startdate: $startdate, starttime: $starttime, readingdate: $readingdate, readingtime: $readingtime, result: $result, visitId: $visitId}';
   }

   List<LaboratoryInvestigationTest> fromJsonDecodedMap(List dynamicList) {
     List<LaboratoryInvestigationTest> LabInvestigationList = [];

     if (dynamicList != null) {
       dynamicList.forEach((e) {
         LaboratoryInvestigationTest labInvestTest = LaboratoryInvestigationTest.fromJson(e);
         LabInvestigationList.add(labInvestTest);
       });
     }


     return LabInvestigationList;
   }


}