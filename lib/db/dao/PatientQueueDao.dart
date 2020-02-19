

import 'package:ehr_mobile/util/RecordStatusConstants.dart';
import 'package:ehr_mobile/util/util.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class PatientQueueDao {

  var id=StrField('id');
  var status=StrField('status');
  var visitId=StrField('visitId');
  var queue_code=StrField('queue_code');
  var queue_name=StrField('queue_name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'PatientQueue';
  PatientQueueDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }


  Future insertFromEhr(String queueCode,queueName,String visit) async {
    Insert inserter = new Insert(tableName);
    inserter.set(id, Uuid.generateV4());
    inserter.set(queue_code, queueCode);
    inserter.set(queue_name, queueName);
    inserter.set(visitId, visit);
    inserter.set(status,IMPORTED);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }
}