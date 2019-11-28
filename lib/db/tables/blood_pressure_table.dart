
import 'package:ehr_mobile/util/custom_date_converter.dart';

import 'vital_base_table.dart';

class BloodPressureTable extends VitalBaseTable{

  double systolic;
  double diastolic;

  static BloodPressureTable fromJson(Map map) {
    var bp = BloodPressureTable();
    bp.id = map['id'];
    bp.personId = map['personId'];
    bp.visitId = map['visitId'];
    bp.dateTime = const CustomDateTimeConverter().fromIntToSqlDate(map['dateTime']);
    bp.status = map['status'];
    bp.systolic = map['systolic'];
    bp.diastolic = map['diastolic'];
    return bp;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'personId': personId,
    'visitId': visitId,
    'dateTime': dateTime,
    'status': status,
    'systolic': systolic,
    'diastolic': diastolic,
  };
}