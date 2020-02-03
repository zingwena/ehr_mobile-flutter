
import 'package:ehr_mobile/db/tables/visit_table.dart';
import 'package:ehr_mobile/model/enums/enums.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class VisitDao extends BaseDao{

  var personId = new StrField('personId');
  var patientType = new IntField('patientType');
  var time = new DateTimeField('time');
  var discharged = new StrField('discharged');

  var hospitalNumber = new StrField('hospitalNumber');

  var code = new StrField('code');
  var name = new StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Visit';
  VisitDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds visit by [id]
  Future<VisitTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var visit = VisitTable.fromJson(map);
    return visit;
  }


  Future<VisitTable> findByPersonId(String personId) async {
    Find param = new Find(tableName);

    param.where(this.personId.eq(personId));

    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var visit = VisitTable.fromJson(map);
    return visit;
  }

  /// Finds all visits
  Future<List<VisitTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    List<VisitTable> visits = new List<VisitTable>();

    for (Map map in maps) {
      var visit = VisitTable.fromJson(map);
      visits.add(visit);
    }
    return visits;
  }

  Future insertFromEhr(Map map,String ehrPersonId) async {
    Insert inserter = new Insert(tableName);
    inserter.set(patientType,map['type']);
    inserter.set(id, map['patientId']);
    inserter.set(code, map['facility']['id']);
    inserter.set(name, map['facility']['name']);
    inserter.set(personId,ehrPersonId);
    inserter.set(discharged, const CustomDateTimeConverter().fromEhrJson(map['discharged']));
    inserter.set(time,const CustomDateTimeConverter().fromEhrDateTimeJson(map['time']));
    inserter.set(hospitalNumber, map['hospitalNumber']);
    inserter.set(status, RecordStatus.IMPORTED.toString());
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}