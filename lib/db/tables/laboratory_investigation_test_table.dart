
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'base_table.dart';
@JsonSerializable(explicitToJson: true)


class LaboratoryInvestigationTestTable extends BaseTable{

  String id;
  String laboratoryInvestigationId;
  String startTime;
  String endTime;

  String visitId;
  String resultCode;
  String resultName;
  String testKitCode;
  String testKitName;
  String batchIssueId;

  static LaboratoryInvestigationTestTable fromJson(Map map) {
    var labInvestigation = LaboratoryInvestigationTestTable();
    labInvestigation.id = map['id'];
    labInvestigation.status=map['status'];
    labInvestigation.laboratoryInvestigationId=map['laboratoryInvestigationId'];

    labInvestigation.startTime = const CustomDateTimeConverter().fromIntToSqlDateTime(map['startTime']);
    labInvestigation.endTime = const CustomDateTimeConverter().fromIntToSqlDateTime(map['endTime']);

    labInvestigation.visitId=map['visitId'];
    labInvestigation.resultCode=map['resultCode'];
    labInvestigation.resultName=map['resultName'];

    labInvestigation.testKitCode=map['testKitCode'];
    labInvestigation.testKitCode=map['testKitCode'];
    labInvestigation.batchIssueId=map['batchIssueId'];

    return labInvestigation;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'laboratoryInvestigationId': laboratoryInvestigationId,
    'startTime': startTime,
    'endTime': endTime,

    'status':status,
    'visitId': visitId,
    'resultCode': resultCode,
    'resultName': resultName,
    'testKitCode': testKitCode,
    'testKitName': testKitName,
    'batchIssueId':batchIssueId
  };
}