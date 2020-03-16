
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'base_table.dart';
@JsonSerializable(explicitToJson: true)


class ArtInitiationTable extends BaseTable{
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


  static ArtInitiationTable fromJson(Map map) {
    var art = ArtInitiationTable();

    art.id=map['id'];
    art.status=map['status'];
    art.regimenType = map['regimenType'];
    art.date = const CustomDateTimeConverter().fromIntToSqlDate(map['date']);
    art.artId = map['artId'];
    art.state = map['state'];
    art.regimen_code = map['regimen_code'];
    art.regimen_name = map['regimen_name'];
    art.reason_code = map['reason_code'];
    art.reason_name = map['reason_name'];
    return art;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'status':status,
    'regimenType':regimenType,
    'date':date,
    'artId':artId,
    'state': state,
    'adverseEventStatus_code': adverseEventStatus_code,
    'adverseEventStatus_name': adverseEventStatus_name,
    'reason_code': reason_code,
    'reason_name': reason_name,
    'regimen_code': regimen_code,
    'regimen_name': regimen_name,





  };
}
