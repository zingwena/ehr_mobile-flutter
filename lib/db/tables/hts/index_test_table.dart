
import 'package:ehr_mobile/util/custom_date_converter.dart';

import '../base_table.dart';

class IndexTestTable extends BaseTable {

  String personId;
  String date;
  String visitId;

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
  };
}