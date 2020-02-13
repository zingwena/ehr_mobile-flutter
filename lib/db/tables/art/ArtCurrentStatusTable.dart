

import 'package:ehr_mobile/util/custom_date_converter.dart';

import '../base_table.dart';

class ArtCurrentStatusTable  extends BaseTable{

    String date;
    String artId;
    String state;

    String regimen_code;
    String regimen_name;

    String reason_code;
    String reason_name;

    String regimenType;

    String adverseEventStatus_code;
    String adverseEventStatus_name;

  static ArtCurrentStatusTable fromJson(Map map) {
    var art = ArtCurrentStatusTable();

    art.id=map['id'];
    art.status=map['status'];

    art.artId = map['artId'];

    art.reason_code = map['reason_code'];
    art.reason_name = map['reason_name'];

    art.date = const CustomDateTimeConverter().fromIntToSqlDate(map['date']);

    art.regimen_code = map['regimen_code'];
    art.regimen_name = map['regimen_name'];

    art.regimenType = map['regimenType'];

    art.adverseEventStatus_code=map['adverseEventStatus_code'];
    art.adverseEventStatus_name=map['adverseEventStatus_name'];

    return art;
  }

  Map<String, dynamic> toJson() => {

    'id':id,
    'status':status,
    'artId':artId,
    'reason_code':reason_code,
    'reason_name':reason_name,

    'date':date,
    'regimen_code':regimen_code,
    'regimen_name':regimen_name,

    'regimenType':regimenType,

    'adverseEventStatus_code':adverseEventStatus_code,
    'appointmentOutcome_name':adverseEventStatus_name,

  };
}