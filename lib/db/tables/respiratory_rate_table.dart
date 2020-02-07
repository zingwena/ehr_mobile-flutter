
import 'package:ehr_mobile/util/custom_date_converter.dart';

import 'vital_base_value_table.dart';

class RespiratoryTable extends VitalBaseValueTable{

  static RespiratoryTable fromJson(Map map) {
    var resp = RespiratoryTable();
    resp.id = map['id'];
    resp.personId = map['personId'];
    resp.visitId = map['visitId'];
    resp.dateTime = const CustomDateTimeConverter().fromIntToSqlDate(map['dateTime']);
    resp.status = map['status'];
    resp.value='${map['value']}';
    return resp;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'personId': personId,
    'visitId': visitId,
    'dateTime': dateTime,
    'status': status,
    'value': value,
  };

}