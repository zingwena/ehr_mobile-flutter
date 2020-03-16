

import 'package:ehr_mobile/util/custom_date_converter.dart';

import '../base_table.dart';

class ArtLinkageFormTable extends BaseTable{
  String artId;
  String linkageFrom;
  String linkageNumber;
  String dateHivConfirmed;
  String otherInstitution;
  String hivTestUsed;
  String testReason_name;
  String testReason_code;
  bool reTested;
  String dateRetested;
  String facility_name;
  String facility_code;

  static ArtLinkageFormTable fromJson(Map map) {
    var art = ArtLinkageFormTable();

    art.id=map['id'];
    art.status=map['status'];
    art.artId = map['artId'];
    art.linkageFrom = map['linkageFrom'];
    art.linkageNumber = map['linkageNumber'];
    art.otherInstitution = map['otherInstitution'];
    art.hivTestUsed = map['hivTestUsed'];
    art.testReason_name = map['testReason_name'];
    art.testReason_code = map['testReason_code'];
    art.reTested = map['reTested'];
    art.facility_name = map['facility_name'];
    art.facility_code = map['facility_code'];
    art.dateRetested =const CustomDateTimeConverter().fromIntToSqlDate(map['dateRetested']);
    art.dateHivConfirmed = const CustomDateTimeConverter().fromIntToSqlDate(map['dateHivConfirmed']);
    return art;
  }

  Map<String, dynamic> toJson() => {
  'id':id,
  'status':status,
  'artId': artId,
  'linkageFrom': linkageFrom,
  'linkageNumber': linkageNumber,
  'dateHivConfirmed': dateHivConfirmed,
  'otherInstitution': otherInstitution,
  'hivTestUsed': hivTestUsed,
  'testReason_name': testReason_name,
  'testReason_code': testReason_code,
  'reTested': reTested,
  'dateRetested': dateRetested,
  'facility_name': facility_name,
  'facility_code': facility_code

  };
}