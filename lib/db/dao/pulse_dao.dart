

import 'package:ehr_mobile/db/tables/pulse_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'vital_base_dao.dart';

class PulseDao extends VitalBaseDao{
  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Pulse';
  PulseDao(SqfliteAdapter _adapter){
    this._adapter =_adapter;
  }

  Future<int> setSyncd(String personId) async {
    Update updater = new Update(tableName);
    updater.where(this.personId.eq(personId));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }


  /// Finds by [personId]
  Future<List<PulseTable>> findByPersonId(String personId) async {
    Find param = new Find(tableName);
    param.where(this.personId.eq(personId));
    var values=List<PulseTable>();
    List<Map> maps = await _adapter.find(param);
    for(Map map in maps){
      values.add(PulseTable.fromJson(map));
    }
    return values;
  }

}