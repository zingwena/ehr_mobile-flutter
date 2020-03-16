

import 'package:ehr_mobile/util/custom_date_converter.dart';

import '../base_table.dart';

class ArtAppointmentTable extends BaseTable{

    String artId;
    String reason_code;
    String reason_name;
    String date;
    String followUpReason_code;
    String followUpReason_name;
    String followupDate;
    String appointmentOutcomeDate;
    String appointmentOutcome_code;
    String appointmentOutcome_name;

    static ArtAppointmentTable fromJson(Map map) {
      var art = ArtAppointmentTable();

      art.id=map['id'];
      art.status=map['status'];
      art.artId = map['artId'];
      art.reason_code = map['reason_code'];
      art.reason_name = map['reason_name'];
      art.date = const CustomDateTimeConverter().fromIntToSqlDate(map['date']);
      art.followUpReason_code = map['followUpReason_code'];
      art.followUpReason_name = map['followUpReason_name'];
      art.followupDate = const CustomDateTimeConverter().fromIntToSqlDate(map['followupDate']);
      art.appointmentOutcomeDate = const CustomDateTimeConverter().fromIntToSqlDate(map['appointmentOutcomeDate']);
      art.appointmentOutcome_code=map['appointmentOutcome_code'];
      art.appointmentOutcome_name=map['appointmentOutcome_name'];

      return art;
    }

    Map<String, dynamic> toJson() => {
      'id':id,
      'status':status,
      'artId':artId,
      'reason_code':reason_code,
      'reason_name':reason_name,
      'date':date,
      'followUpReason_code':followUpReason_code,
      'followUpReason_name':followUpReason_name,
      'followupDate':followupDate,
      'appointmentOutcomeDate':appointmentOutcomeDate,
      'appointmentOutcome_code':appointmentOutcome_code,
      'appointmentOutcome_name':appointmentOutcome_name,
    };
}