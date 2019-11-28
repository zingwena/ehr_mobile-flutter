

import 'package:ehr_mobile/db/tables/blood_pressure_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'vital_base_dao.dart';

class BloodPressureDao extends VitalBaseDao{

  var systolic=DoubleField('systolic');
  var diastolic=DoubleField('diastolic');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'BloodPressure';
  BloodPressureDao(SqfliteAdapter _adapter){
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
  Future<List<BloodPressureTable>> findByPersonId(String personId) async {
    Find param = new Find(tableName);
    param.where(this.personId.eq(personId));
    var values=List<BloodPressureTable>();
    List<Map> maps = await _adapter.find(param);
    for(Map map in maps){
      values.add(BloodPressureTable.fromJson(map));
    }
    return values;
  }
}