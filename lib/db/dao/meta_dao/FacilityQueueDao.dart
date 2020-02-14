


import 'package:ehr_mobile/db/tables/meta_tables/FacilityQueueTable.dart';
import 'package:ehr_mobile/model/enums/enums.dart';
import 'package:ehr_mobile/util/RecordStatusConstants.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class FacilityQueueDao {

  var id=StrField('id');
  var status=StrField('status');
  var queue_code=StrField('queue_code');
  var queue_name=StrField('queue_name');

  var facility_code=StrField('facility_code');
  var facility_name=StrField('facility_name');

  var department_code=StrField('department_code');
  var department_name=StrField('department_name');

  var beds=IntField('beds');


  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'FacilityQueue';
  FacilityQueueDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds all visits
  Future<List<FacilityQueueTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<FacilityQueueTable>();

    for (Map map in maps) {
      var status = FacilityQueueTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(String queueId,String queueCode,String queueName, String deptCode,String deptName,int bed) async {
    Insert inserter = new Insert(tableName);

    inserter.set(id, queueId);
    inserter.set(queue_code, queueCode);
    inserter.set(queue_name, queueName);

    inserter.set(department_code, deptCode);
    inserter.set(department_name, deptName);
    inserter.set(status,'$IMPORTED');
    inserter.set(beds, bed);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}