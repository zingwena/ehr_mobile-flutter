

import 'package:ehr_mobile/util/custom_date_converter.dart';

import 'vital_base_value_table.dart';

class WeightTable extends VitalBaseValueTable{

  static WeightTable fromJson(Map map) {
    var weight = WeightTable();
    weight.id = map['id'];
    weight.personId = map['personId'];
    weight.visitId = map['visitId'];
    weight.dateTime = const CustomDateTimeConverter().fromIntToSqlDate(map['dateTime']);
    weight.status = map['status'];
    weight.value='${map['value']}';
    return weight;
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
