
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'laboratory_investigation.g.dart';
@JsonSerializable()
@CustomDateTimeConverter()
class LaboratoryInvestigation{
  int facilityId;



 DateTime resultDate;

  LaboratoryInvestigation(this.facilityId,
      this.resultDate);

  factory LaboratoryInvestigation.fromJson(Map<String, dynamic> json) => _$LaboratoryInvestigationFromJson(json) ;

  Map<String, dynamic> toJson() =>_$LaboratoryInvestigationToJson(this) ;


  static mapFromJson(List dynamicList){
    List<LaboratoryInvestigation> laboratoryInvestigationList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        LaboratoryInvestigation nationality= LaboratoryInvestigation.fromJson(e);
        laboratoryInvestigationList.add(nationality);
      });
    }
    return laboratoryInvestigationList;
  }


}