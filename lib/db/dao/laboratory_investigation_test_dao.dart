
import 'package:ehr_mobile/db/tables/laboratory_investigation_test_table.dart';
import 'package:ehr_mobile/util/RecordStatusConstants.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class LaboratoryInvestigationTestDao extends BaseDao{

  var id = new StrField('id');
  var laboratoryInvestigationId = new StrField('laboratoryInvestigationId');

  var startTime = new DateTimeField('startTime');
  var endTime = new DateTimeField('endTime');

  final visitId = new StrField('visitId');
  final resultCode = new StrField('result_code');
  final resultName = new StrField('result_name');
  final testKitCode = new StrField('testkit_code');
  final testKitName = new StrField('testkit_name');
  final batchIssueId = new StrField('batchIssueId');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'LaboratoryInvestigationTest';
  LaboratoryInvestigationTestDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds labInvestigationTest by [id]
  Future<LaboratoryInvestigationTestTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var labInvestigationTest = LaboratoryInvestigationTestTable.fromJson(map);
    return labInvestigationTest;
  }

  /// Finds labInvestigationTests by [personInvestigationId]
  Future<List<LaboratoryInvestigationTestTable>> findByLaboratoryInvestigationId(String laboratoryInvestigationId) async {
    Find finder = new Find(tableName);
    finder.where(this.laboratoryInvestigationId.eq(laboratoryInvestigationId));
    List<Map> maps = await (await _adapter.find(finder)).toList();
    List<LaboratoryInvestigationTestTable> labInvestigationTests = new List<LaboratoryInvestigationTestTable>();
    for (Map map in maps) {
      var labInvestigation = LaboratoryInvestigationTestTable.fromJson(map);
      labInvestigationTests.add(labInvestigation);
    }
    return labInvestigationTests;
  }

  /// Finds all labInvestigationTests
  Future<List<LaboratoryInvestigationTestTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = await (await _adapter.find(finder)).toList();

    List<LaboratoryInvestigationTestTable> labInvestigationTests = new List<LaboratoryInvestigationTestTable>();

    for (Map map in maps) {
      var labInvestigationTest = LaboratoryInvestigationTestTable.fromJson(map);
      labInvestigationTests.add(labInvestigationTest);
    }
    return labInvestigationTests;
  }

  //

  Future insertFromEhr(Map map,String labId,String visit) async {

    Insert inserter = new Insert(tableName);
    inserter.set(visitId, visit);
    inserter.set(laboratoryInvestigationId, labId);
    inserter.set(id, map['laboratoryInvestigationTestId']);
    inserter.set(status,IMPORTED);

    if (map['testKit'] != null) {
      inserter.set(testKitName,map['testKit']['id']);
      inserter.set(testKitCode,map['testKit']['name']);
    }

    if (map['result'] != null) {
      inserter.set(resultCode,map['result']['id']);
      inserter.set(resultName,map['result']['name']);
    }

    if (map['batchIssue'] != null) {
      inserter.set(batchIssueId,map['batchIssue']['batchIssueId']);
    }

    inserter.set(startTime,const CustomDateTimeConverter().fromEhrDateTimeJson(map['time']));
    inserter.set(endTime,const CustomDateTimeConverter().fromEhrDateTimeJson(map['readingTime']));

    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }
}