
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'base_table.dart';
import 'laboratory_investigation_test_table.dart';
@JsonSerializable(explicitToJson: true)


class LaboratoryInvestigationTable extends BaseTable{

  String facilityId;
  String personInvestigationId;
  String resultDate;
  String id;
  List<LaboratoryInvestigationTestTable>laboratoryInvestigationTestDtos=new List();

  static LaboratoryInvestigationTable fromJson(Map map) {
    var labInvestigation = LaboratoryInvestigationTable();
    labInvestigation.id = map['id'];
    labInvestigation.status=map['status'];
    labInvestigation.facilityId=map['facilityId'];
    labInvestigation.resultDate = const CustomDateTimeConverter().fromIntToSqlDate(map['resultDate']);
    return labInvestigation;
  }

  Map<String, dynamic> toJson() => {
    'facilityId':facilityId,
    'personInvestigationId':personInvestigationId,
    'resultDate':resultDate,
    'id':id,
    'laboratoryInvestigationTestDtos':laboratoryInvestigationTestDtos
  };
}
