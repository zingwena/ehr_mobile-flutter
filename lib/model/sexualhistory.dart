import 'package:json_annotation/json_annotation.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
part 'sexualhistory.g.dart';
@JsonSerializable()
class SexualHistory{

 String personId;
 bool sexuallyActive;
 DateTime sexWithMaleDate;
 DateTime sexWithFemaleDate;
 int numberOfSexualPartners;
 int numberOfSexualPartnersLastTwelveMonths;

 SexualHistory(String personId, bool sexuallyActive, DateTime sexWithMaleDate, DateTime sexWithFemaleDate,  int numberOfSexualPartners,
     int numberOfSexualPartnersLastTwelveMonths){
   this.personId = personId;
   this.sexuallyActive = sexuallyActive;
   this.sexWithMaleDate = sexWithMaleDate;
   this.sexWithFemaleDate = sexWithFemaleDate;
   this.numberOfSexualPartners = numberOfSexualPartners;
   this.numberOfSexualPartnersLastTwelveMonths = numberOfSexualPartnersLastTwelveMonths;
 }

 factory SexualHistory.fromJson(Map<String, dynamic> json) => _$SexualHistoryFromJson(json);

 Map<String, dynamic> toJson() => _$SexualHistoryToJson(this);

 @override
 String toString() {
   return 'SexualHistory{sexuallyActive: $sexuallyActive, sexWithMaleDate: $sexWithMaleDate, sexWithFemaleDate: $sexWithFemaleDate, '
       ' numberOfSexualPartners:$numberOfSexualPartners, numberOfSexualPartnersLastTwelveMonths:$numberOfSexualPartnersLastTwelveMonths}';
 }

 static List<SexualHistory> fromJsonDecodedMap(List dynamicList) {
   List<SexualHistory> sexualhistorytList = [];

   if (dynamicList != null) {
     dynamicList.forEach((e) {
       SexualHistory sexualHistory = SexualHistory.fromJson(e);
       sexualhistorytList.add(sexualHistory);
     });
   }


   return sexualhistorytList;
 }
}