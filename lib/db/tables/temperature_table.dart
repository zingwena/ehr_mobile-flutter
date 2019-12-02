
import 'package:ehr_mobile/util/custom_date_converter.dart';

import 'vital_base_value_table.dart';

class TemperatureTable extends VitalBaseValueTable{

  static TemperatureTable fromJson(Map map) {
    var temp = TemperatureTable();
    temp.id = map['id'];
    temp.personId = map['personId'];
    temp.visitId = map['visitId'];
    temp.dateTime = const CustomDateTimeConverter().fromIntToSqlDate(map['dateTime']);
    temp.status = map['status'];
    temp.value=map['value'];
    return temp;
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