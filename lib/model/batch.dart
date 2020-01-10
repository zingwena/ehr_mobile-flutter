import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
@JsonSerializable(explicitToJson: true)
@CustomDateTimeConverter()
part 'batch.g.dart';

class Batch {
   String batchNumber;
   DateTime expiryDate;
   String textKitId;
   String testKitName;

   Batch(this.batchNumber, this.expiryDate, this.textKitId, this.testKitName);


   factory Batch.fromJson(Map<String, dynamic> json) => _$BatchFromJson(json);


   Map<String, dynamic> toJson() => _$BatchToJson(this);

   static mapFromJson(List dynamicList){
     List<Batch> batchList=[];
     if(dynamicList!=null){
       dynamicList.forEach((e){
         Batch batch= Batch.fromJson(e);
         batchList.add(batch);
       });
     }
     return batchList;
   }

   @override
   String toString() {
     return 'Batch{batchNumber: $batchNumber, expiryDate: $expiryDate, textKitId: $textKitId, testKitName: $testKitName, }';
   }

   List<Batch> fromJsonDecodedMap(List dynamicList) {
     List<Batch> batchList = [];

     if (dynamicList != null) {
       dynamicList.forEach((e) {
         Batch batch = Batch.fromJson(e);
         batchList.add(batch);
       });
     }
     return batchList;
   }




}