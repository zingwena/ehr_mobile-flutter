
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base_table.dart';
import 'index_contact_table.dart';
@JsonSerializable(explicitToJson: true)


class IndexTestTable extends BaseTable {

  String personId;
  String date;
  String visitId;
  List<IndexContactTable> indexContactDtos=new List();

  static IndexTestTable fromJson(Map map) {
    var itable = IndexTestTable();
    itable.id = map['id'];
    itable.personId = map['personId'];
    itable.date = const CustomDateTimeConverter().fromIntToSqlDate(map['date']);
    itable.status = map['status'];
    return itable;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'personId': personId,
    'date': date,
    'status': status,
    'visitId': visitId,
    'indexContactDtos':indexContactDtos
  };
}