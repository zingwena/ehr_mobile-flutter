

import 'package:ehr_mobile/util/custom_date_converter.dart';

import '../base_table.dart';

class ArtOITable extends BaseTable{
  String date;
  String artId;
  String name;
  String code;


  static ArtOITable fromJson(Map map) {
    var art = ArtOITable();

    art.id=map['id'];
    art.status=map['status'];
    art.artId = map['artId'];
    art.name = map['name'];
    art.code = map['code'];
    art.date = const CustomDateTimeConverter().fromIntToSqlDate(map['date']);
    return art;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'status':status,
    'artId':artId,
    'date':date,
    'name':name,
    'code':code,

  };
}