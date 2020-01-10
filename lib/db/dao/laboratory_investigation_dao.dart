
import 'package:ehr_mobile/db/tables/laboratory_investigation_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class LaboratoryInvestigationDao extends BaseDao{

  var facilityId = new StrField('facilityId');
  var personInvestigationId = new StrField('personInvestigationId');
  var resultDate = new DateTimeField('resultDate');
  final id = new StrField('id');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'LaboratoryInvestigation';
  LaboratoryInvestigationDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds labInvestigation by [id]
  Future<LaboratoryInvestigationTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var labInvestigation = LaboratoryInvestigationTable.fromJson(map);
    return labInvestigation;
  }

  /// Finds labInvestigations by [personInvestigationId]
  Future<List<LaboratoryInvestigationTable>> findByPersonInvestigationId(String personInvestigationId) async {
    Find finder = new Find(tableName);
    finder.where(this.personInvestigationId.eq(personInvestigationId));
    List<Map> maps = await (await _adapter.find(finder)).toList();
    List<LaboratoryInvestigationTable> labInvestigations = new List<LaboratoryInvestigationTable>();
    for (Map map in maps) {
      var labInvestigation = LaboratoryInvestigationTable.fromJson(map);
      labInvestigations.add(labInvestigation);
    }
    return labInvestigations;
  }

  /// Finds all labInvestigations
  Future<List<LaboratoryInvestigationTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = await (await _adapter.find(finder)).toList();

    List<LaboratoryInvestigationTable> labInvestigations = new List<LaboratoryInvestigationTable>();

    for (Map map in maps) {
      var labInvestigation = LaboratoryInvestigationTable.fromJson(map);
      labInvestigations.add(labInvestigation);
    }
    return labInvestigations;
  }

}