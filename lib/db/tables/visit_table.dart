

import 'package:ehr_mobile/util/custom_date_converter.dart';

import 'base_table.dart';

class VisitTable extends BaseTable {

  String personId;
  String patientType;
  String time;
  String discharged;
  String hospitalNumber;
  String code;
  String name;

  static VisitTable fromJson(Map map) {
    var visit = VisitTable();
    visit.id = map['id'];
    visit.status=map['status'];

    visit.personId=map['personId'];
    visit.patientType=map['patientType'];
    visit.time = const CustomDateTimeConverter().fromIntToSqlDateTime(map['time']);
    visit.discharged = const CustomDateTimeConverter().fromIntToSqlDateTime(map['discharged']);
    visit.hospitalNumber= map['hospitalNumber'];

    visit.code = map['code'];
    visit.name= map['name'];
    return visit;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'status':status,
    'personId':personId,

    'patientType':patientType,
    'time':time,
    'discharged':discharged,

    'hospitalNumber':hospitalNumber,
    'code':code,
    'name':name,
  };
}