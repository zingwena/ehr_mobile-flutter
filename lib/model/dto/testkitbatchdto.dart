import 'package:json_annotation/json_annotation.dart';
part'testkitbatchdto.g.dart';

@JsonSerializable(explicitToJson: true)
class TestKitBatchDto {

   String binType;
   String binId;
   String testKitId;

   TestKitBatchDto(this.binType, this.binId, this.testKitId);

   factory TestKitBatchDto.fromJson(Map<String, dynamic> json) => _$TestKitBatchDtoFromJson(json);


   Map<String, dynamic> toJson() => _$TestKitBatchDtoToJson(this);

   static mapFromJson(List dynamicList){
     List<TestKitBatchDto> batchList=[];
     if(dynamicList!=null){
       dynamicList.forEach((e){
         TestKitBatchDto testKitBatchDto= TestKitBatchDto.fromJson(e);
         batchList.add(testKitBatchDto);
       });
     }
     return batchList;
   }

   @override
   String toString() {
     return 'TestKitBatchDto{binType: $binType, binId: $binId, testKitId: $testKitId }';
   }

   List<TestKitBatchDto> fromJsonDecodedMap(List dynamicList) {
     List<TestKitBatchDto> batchList = [];

     if (dynamicList != null) {
       dynamicList.forEach((e) {
         TestKitBatchDto testKitBatchDto = TestKitBatchDto.fromJson(e);
         batchList.add(testKitBatchDto);
       });
     }
     return batchList;
   }




}