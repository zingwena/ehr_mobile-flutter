

import 'package:ehr_mobile/db/tables/meta_tables/TestKitBatchIssueTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class TestKitBatchIssueDao{

  var id=StrField('id');
  var remaining=StrField('remaining');
  var statusAccepted=IntField('statusAccepted');
  var expiredStatus=IntField('expiredStatus');

  var batch_batchNumber=StrField('batch_batchNumber');
  var batch_expiryDate=DateTimeField('batch_expiryDate');
  var batch_textKitId=StrField('batch_textKitId');
  var batch_testKitName=StrField('batch_testKitName');

  var detail_binType=StrField('detail_binType');
  var detail_name=StrField('detail_name');
  var detail_id=StrField('detail_id');

  var quantity=StrField('quantity');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'TestKitBatchIssue';
  TestKitBatchIssueDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds all visits
  Future<List<TestKitBatchIssueTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<TestKitBatchIssueTable>();

    for (Map map in maps) {
      var status = TestKitBatchIssueTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map,String queueName,String queueId) async {
    Insert inserter = new Insert(tableName);

    inserter.set(id,map['batchIssueId']);
    inserter.set(remaining, map['remaining']);
    inserter.set(statusAccepted, map['statusAccepted']);
    inserter.set(expiredStatus, map['expiredStatus']);

    inserter.set(batch_batchNumber, map['batch']['batchNumber']);
    inserter.set(batch_expiryDate, map['batch']['expiryDate']);
    inserter.set(batch_textKitId, map['batch']['testKit']['id']);
    inserter.set(batch_testKitName, map['batch']['testKit']['name']);

    inserter.set(detail_binType, map['binType']);
    inserter.set(detail_name, queueName);
    inserter.set(detail_id, queueId);

    inserter.set(quantity, map['quantity']);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }
}