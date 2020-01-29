
import 'package:ehr_mobile/db/tables/base_table.dart';

class InvestigationTable extends BaseTable{

  String laboratoryTestId;
  String sampleId;

  InvestigationTable fromJson(Map map) {
    var obj = InvestigationTable();
    obj.laboratoryTestId = map['laboratoryTestId'];
    obj.sampleId=map['sampleId'];
    obj.status=map['status'];
    obj.id=map['id'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'laboratoryTestId':laboratoryTestId,
    'sampleId':sampleId,
    'status':status,
    'id':id,
  };

}