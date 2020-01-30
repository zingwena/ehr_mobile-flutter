

import '../base_table.dart';

class ArvCombinationRegimenTable extends BaseTable{

  String regimenType;
  String ageGroup;
  String code;
  String name;

  ArvCombinationRegimenTable fromJson(Map map) {
    var obj = ArvCombinationRegimenTable();
    obj.regimenType = map['regimenType'];
    obj.ageGroup = map['ageGroup'];
    obj.code=map['code'];
    obj.name=map['name'];
    obj.id=map['id'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'regimenType':regimenType,
    'ageGroup':ageGroup,
    'code':code,
    'name':name,
    'id':id,
  };

}