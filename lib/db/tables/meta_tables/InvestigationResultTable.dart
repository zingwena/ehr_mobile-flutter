
import 'package:ehr_mobile/db/tables/base_table.dart';

class InvestigationResultTable extends BaseTable{

  String resultId;
  String investigationId;

  InvestigationResultTable fromJson(Map map) {
    var obj = InvestigationResultTable();
    obj.resultId = map['resultId'];
    obj.investigationId=map['investigationId'];
    obj.status=map['status'];
    obj.id=map['id'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'investigationId':investigationId,
    'resultId':resultId,
    'status':status,
    'id':id,
  };

}