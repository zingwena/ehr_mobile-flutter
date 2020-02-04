
import 'package:ehr_mobile/db/tables/person_investigation_table.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
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

  Future insertFromEhr(Map map,String ehrPersonId) async {
    Insert inserter = new Insert(tableName);
    inserter.set(personId, ehrPersonId);
    if(map['result']!=null){
      if(map['result']['id']!=null){
        inserter.set(resultId, map['result']['id']);
      }else if(map['result']['name']!=null){
        inserter.set(resultId, map['result']['name']);
      }
    }
    inserter.set(investigationId, map['investigationId']);
    inserter.set(status,'IMPORTED');
    inserter.set(id,map['personInvestigationId']);
    inserter.set(date,const CustomDateTimeConverter().fromEhrJson(map['date']));
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}