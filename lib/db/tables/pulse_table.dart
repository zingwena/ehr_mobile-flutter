
import 'package:ehr_mobile/util/custom_date_converter.dart';

import 'vital_base_value_table.dart';

class PulseTable extends VitalBaseValueTable{

  static PulseTable fromJson(Map map) {
    var pulse = PulseTable();
    pulse.id = map['id'];
    pulse.personId = map['personId'];
    pulse.visitId = map['visitId'];
    pulse.dateTime = const CustomDateTimeConverter().fromIntToSqlDate(map['dateTime']);
    pulse.status = map['status'];
    pulse.value=map['value'];
    return pulse;
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