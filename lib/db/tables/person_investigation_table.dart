
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'base_table.dart';
@JsonSerializable(explicitToJson: true)


class PersonInvestigationTable extends BaseTable{

  String personId;
  String investigationId;
  String date;
  String resultId;
  String id;

  static PersonInvestigationTable fromJson(Map map) {
    var personId = PersonInvestigationTable();

    personId.id = map['id'];
    personId.personId=map['personId'];
    personId.status=map['status'];
    personId.investigationId=map['investigationId'];
    personId.resultId = map['resultId'];
    personId.date = const CustomDateTimeConverter().fromIntToSqlDate(map['date']);

    return personId;
  }

  Map<String, dynamic> toJson() => {
    'personId':personId,
    'investigationId':investigationId,
    'date':date,
    'resultId':resultId,
    'id':id
  };
}