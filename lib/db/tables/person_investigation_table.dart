
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'base_table.dart';
import 'laboratory_investigation_table.dart';
@JsonSerializable(explicitToJson: true)


class PersonInvestigationTable extends BaseTable{

  String personId;
  String investigationId;
  String date;
  String resultId;
  LaboratoryInvestigationTable laboratoryInvestigationDto;

  static PersonInvestigationTable fromJson(Map map) {
    var person = PersonInvestigationTable();

    person.id = map['id'];
    person.personId=map['personId'];
    person.status=map['status'];
    person.investigationId=map['investigationId'];
    person.resultId = map['resultId'];
    person.date = const CustomDateTimeConverter().fromIntToSqlDate(map['date']);

    return person;
  }

  Map<String, dynamic> toJson() => {
    'personId':personId,
    'investigationId':investigationId,
    'date':date,
    'resultId':resultId,
    'id':id,
    'laboratoryInvestigationDto':laboratoryInvestigationDto
  };
}