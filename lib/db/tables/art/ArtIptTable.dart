

import 'package:ehr_mobile/util/custom_date_converter.dart';

import '../base_table.dart';

class ArtIptTable extends BaseTable{

  String artId;
  String date;
  String status_name;
  String status_code;
  String reason_name;
  String reason_code;

  static ArtIptTable fromJson(Map map) {
    var art = ArtIptTable();

    art.id=map['id'];
    art.status=map['status'];
    art.artId = map['artId'];
    art.reason_code = map['reason_code'];
    art.reason_name = map['reason_name'];
    art.status_name = map['status_name'];
    art.status_code = map['status_code'];
    art.date = const CustomDateTimeConverter().fromIntToSqlDate(map['date']);
    return art;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'status':status,
    'artId':artId,
    'date':date,
    'reason_code':reason_code,
    'reason_name':reason_name,
    'status_name':status_name,
    'status_code':status_code,
  };
}