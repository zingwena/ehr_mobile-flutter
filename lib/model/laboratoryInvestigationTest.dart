
import 'package:ehr_mobile/model/result.dart';
import 'package:json_annotation/json_annotation.dart';
part 'laboratoryInvestigationTest.g.dart';

@JsonSerializable()
class LaboratoryInvestigationTest{
   String id;
   String laboratoryInvestigationId;
   String startTime;
   String endTime;
   DateTime startDate;
   DateTime endDate;
   Result result;
   String visitId;
   String testkitId;


   LaboratoryInvestigationTest(this.id, this.laboratoryInvestigationId,
       this.startDate, this.endDate, this.result, this.visitId, this.testkitId, this.startTime, this.endTime);

   factory LaboratoryInvestigationTest.fromJson(Map<String, dynamic> json) => _$LaboratoryInvestigationTestFromJson(json);


   Map<String, dynamic> toJson() => _$LaboratoryInvestigationTestToJson(this);

   static mapFromJson(List dynamicList){
     List<LaboratoryInvestigationTest> labInvestigationList=[];
     if(dynamicList!=null){
       dynamicList.forEach((e){
         LaboratoryInvestigationTest laboratoryInvestigationTest= LaboratoryInvestigationTest.fromJson(e);
         labInvestigationList.add(laboratoryInvestigationTest);
       });
     }
     return labInvestigationList;
   }



   @override
   String toString() {
     return 'LaboratoryInvestigationTest{id: $id, laboratoryInvestigationId: $laboratoryInvestigationId, startTime: $startTime, endTime: $endTime, result: $result, visitId: $visitId, testkiId: $testkitId}';
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