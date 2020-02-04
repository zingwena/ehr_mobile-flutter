
import 'package:ehr_mobile/db/tables/laboratory_investigation_table.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:ehr_mobile/util/logger.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class LaboratoryInvestigationDao extends BaseDao{

  var facilityId = new StrField('facilityId');
  var personInvestigationId = new StrField('personInvestigationId');
  var resultDate = new DateTimeField('resultDate');

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


  Future<LaboratoryInvestigationTable> findPersonInvestigationId(String personInvestigationId) async {
    Find param = new Find(tableName);

    param.where(this.personInvestigationId.eq(personInvestigationId));

    Map map = await _adapter.findOne(param);

    var labInvestigation = LaboratoryInvestigationTable.fromJson(map);
    return labInvestigation;
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

  Future insertFromEhr(Map map,String facility) async {
    Insert inserter = new Insert(tableName);
    inserter.set(facilityId, facility);
    inserter.set(personInvestigationId, map['laboratoryInvestigationId']);
    inserter.set(id, map['laboratoryInvestigationId']);
    inserter.set(status,'IMPORTED');
    inserter.set(resultDate,const CustomDateTimeConverter().fromEhrJson(map['date']));
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}