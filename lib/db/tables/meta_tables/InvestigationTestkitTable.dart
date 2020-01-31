
import 'package:ehr_mobile/db/tables/base_table.dart';

class InvestigationTestkitTable extends BaseTable{

  String investigationId;
  String testKitId;

  InvestigationTestkitTable fromJson(Map map) {
    var obj = InvestigationTestkitTable();
    obj.investigationId = map['investigationId'];
    obj.testKitId=map['testKitId'];
    obj.status=map['status'];
    obj.id=map['id'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'investigationId':investigationId,
    'testKitId':testKitId,
    'status':status,
    'id':id,
  };

}