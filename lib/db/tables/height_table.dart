
import 'package:ehr_mobile/util/custom_date_converter.dart';

import 'vital_base_value_table.dart';

class HeightTable extends VitalBaseValueTable{

  static HeightTable fromJson(Map map) {
    var height = HeightTable();
    height.id = map['id'];
    height.personId = map['personId'];
    height.visitId = map['visitId'];
    height.dateTime = const CustomDateTimeConverter().fromIntToSqlDate(map['dateTime']);
    height.status = map['status'];
    height.value=map['value'];
    return height;
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