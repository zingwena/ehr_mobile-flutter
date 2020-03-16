
import 'package:ehr_mobile/db/tables/person_table.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:ehr_mobile/util/relationship_type_convertor.dart';
import 'package:json_annotation/json_annotation.dart';
import '../base_table.dart';
@JsonSerializable(explicitToJson: true)


class IndexContactTable extends BaseTable{

  String indexTestId;
  String personId;
  String relation;
  String hivStatus;
  String dateOfHivStatus;
  int fearOfIpv;
  String disclosureMethodPlanId;
  String testingPlanId;
  int disclosureStatus;
  String disclosureMethodId;
  PersonTable personDto;

  static IndexContactTable fromJson(Map map) {
    var icTable = IndexContactTable();

    icTable.id = map['id'];
    icTable.indexTestId=map['indexTestId'];
    icTable.status=map['status'];
    icTable.personId = map['personId'];

    icTable.relation = map['relation'];
    icTable.hivStatus = map['hivStatus'];

    icTable.dateOfHivStatus=const CustomDateTimeConverter().fromIntToSqlDate(map['dateOfHivTest']);
    icTable.fearOfIpv = map['fearOfIpv'];

    icTable.disclosureMethodPlanId = map['disclosureMethodPlanId'];
    icTable.testingPlanId = map['testingPlanId'];
    icTable.disclosureStatus = map['disclosureStatus'];

    icTable.disclosureMethodId= map['disclosureMethodId'];

    return icTable;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'indexTestId':indexTestId,
    'personId': personId,
    'relation': relation,
    'hivStatus': hivStatus,
    'dateOfHivStatus': dateOfHivStatus,
    'fearOfIpv': fearOfIpv,
    'disclosureMethodPlanId': disclosureMethodPlanId,
    'testingPlanId': testingPlanId,
    'disclosureStatus': disclosureStatus,
    'disclosureMethodId': disclosureMethodId,
    'status': status,
    'personDto':personDto.toEhrJson(),
  };
}