import 'package:ehr_mobile/util/custom_date_converter.dart';

import '../base_table.dart';

class HtsTable extends BaseTable{
  String personId;
  String visitId;
  String htsType;
  String laboratoryInvestigationId;
  String dateOfHivTest;
  String entryPointId;
  String htsApproach;
  String reasonForHivTestingId;
  String htsModelId;

  int preTestInformationGiven;
  int newTestInClientLife;
  int newTestPregLact;
  int coupleCounselling;
  int optOutOfTest;
  int resultReceived;

  String reasonForNotIssuingResultId;
  int postTestCounselled;
  String datePostTestCounselled;

  int consentToIndexTesting;

  static HtsTable fromJson(Map map) {
    var htsTable = HtsTable();
    htsTable.id = map['id'];
    htsTable.personId = map['personId'];
    htsTable.visitId = map['visitId'];
    htsTable.htsType = map['htsType'];
    htsTable.laboratoryInvestigationId = map['laboratoryInvestigationId'];
    htsTable.dateOfHivTest = const CustomDateTimeConverter().fromIntToSqlDate(map['dateOfHivTest']);
    htsTable.entryPointId = map['entryPointId'];
    htsTable.htsApproach = map['htsApproach'];
    htsTable.reasonForHivTestingId = map['reasonForHivTestingId'];
    htsTable.htsModelId = map['htsModelId'];

    htsTable.preTestInformationGiven = map['preTestInformationGiven'];
    htsTable.newTestInClientLife = map['newTestInClientLife'];
    htsTable.newTestPregLact = map['newTestPregLact'];
    htsTable.coupleCounselling = map['coupleCounselling'];
    htsTable.optOutOfTest = map['optOutOfTest'];
    htsTable.resultReceived = map['resultReceived'];

    htsTable.reasonForNotIssuingResultId = map['reasonForNotIssuingResultId'];
    htsTable.postTestCounselled = map['postTestCounselled'];
    htsTable.datePostTestCounselled = map['datePostTestCounselled'];

    htsTable.status = map['status'];
    htsTable.consentToIndexTesting = map['consentToIndexTesting'];
    return htsTable;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'personId': personId,
        'visitId': visitId,
        'htsType': htsType,
        'laboratoryInvestigationId': laboratoryInvestigationId,
        'dateOfHivTest': dateOfHivTest,
        'entryPointId': entryPointId,
        'htsApproach': htsApproach,
        'reasonForHivTestingId': reasonForHivTestingId,
        'htsModelId': htsModelId,
        'preTestInformationGiven': preTestInformationGiven,
        'newTestInClientLife': newTestInClientLife,
        'newTestPregLact': newTestPregLact,
        'coupleCounselling': coupleCounselling,
        'optOutOfTest': optOutOfTest,
        'resultReceived': resultReceived,
        'reasonForNotIssuingResultId': reasonForNotIssuingResultId,
        'postTestCounselled': postTestCounselled,
        'datePostTestCounselled': datePostTestCounselled,
        'status': status,
        'consentToIndexTesting': consentToIndexTesting
      };
}
