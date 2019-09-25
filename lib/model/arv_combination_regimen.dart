
import 'package:ehr_mobile/model/base_code.dart';
import 'package:json_annotation/json_annotation.dart';
part 'arv_combination_regimen.g.dart';
@JsonSerializable()
class ArvCombinationRegimen extends BaseCode{
  ArvCombinationRegimen(String name,String code){
    this.name = name;
    this.code = code;
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