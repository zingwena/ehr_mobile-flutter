
import 'package:ehr_mobile/db/tables/person_investigation_table.dart';
import 'package:ehr_mobile/util/logger.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class PersonInvestigationDao extends BaseDao{

  var personId = new StrField('personId');
  var investigationId = new StrField('investigationId');

  var date = new DateTimeField('date');
  var resultId = new StrField('resultId');
  final id = new StrField('id');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'PersonInvestigation';
  PersonInvestigationDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds one personInvestigation by [id]
  Future<PersonInvestigationTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var personInvestigation = PersonInvestigationTable.fromJson(map);
    return personInvestigation;
  }

  Future<List<PersonInvestigationTable>> findByPersonId(String personId) async {
    Find finder = new Find(tableName);
    finder.where(this.personId.eq(personId));

    List<Map> maps = await (await _adapter.find(finder)).toList();

    List<PersonInvestigationTable> personInvestigations = new List<PersonInvestigationTable>();

    for (Map map in maps) {
      var personInvestigation = PersonInvestigationTable.fromJson(map);
      personInvestigations.add(personInvestigation);
    }
    return personInvestigations;
  }

//  /// Finds one personInvestigation by [personId]
//  Future<PersonInvestigationTable> findByPersonId(String personId) async {
//    Find finder = new Find(tableName);
//    finder.where(this.personId.eq(personId));
//    List<Map> maps = await (await _adapter.find(finder)).toList();
//    List<PersonInvestigationTable> personInvestigations = new List<PersonInvestigationTable>();
//    for (Map map in maps) {
//      var personInvestigation = PersonInvestigationTable.fromJson(map);
//      personInvestigations.add(personInvestigation);
//    }
//    return personInvestigations;
//  }

  /// Finds all personInvestigations
  Future<List<PersonInvestigationTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = await (await _adapter.find(finder)).toList();

    List<PersonInvestigationTable> personInvestigations = new List<PersonInvestigationTable>();

    for (Map map in maps) {
      var personInvestigation = PersonInvestigationTable.fromJson(map);
      personInvestigations.add(personInvestigation);
    }
    return personInvestigations;
  }

}