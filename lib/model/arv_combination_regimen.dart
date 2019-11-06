
import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'arv_combination_regimen.g.dart';
@JsonSerializable()
class ArvCombinationRegimen extends BaseCode{
  String regimen_type;
  String age_group;
  ArvCombinationRegimen(String name,String code, String regimen_type, String age_group){
    this.name = name;
    this.code = code;
    this.regimen_type = regimen_type;
    this.age_group = age_group;
  }


  factory ArvCombinationRegimen.fromJson(Map<String,dynamic> json) => _$ArvCombinationRegimenFromJson(json);

  Map<String,dynamic> toJson() => _$ArvCombinationRegimenToJson(this);

  static mapFromJson(List dynamicList){
    List<ArvCombinationRegimen> arvCombinationRegimenList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        ArvCombinationRegimen arvCombinationRegimen= ArvCombinationRegimen.fromJson(e);
        arvCombinationRegimenList.add(arvCombinationRegimen);
      });
    }
    return arvCombinationRegimenList;
  }



}