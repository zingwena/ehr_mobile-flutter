
import 'package:ehr_mobile/db/tables/sexual_history_question_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class SexualHistoryQuestionDao extends BaseDao{

  var sexualHistoryId = new StrField('sexualHistoryId');
  var responseType = new IntField('responseType');
  var code = new StrField('code');
  var name = new StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'SexualHistoryQuestion';
  SexualHistoryQuestionDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds sexualHistoryQn by [id]
  Future<SexualHistoryQuestionTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var sexualHistoryQn = SexualHistoryQuestionTable.fromJson(map);
    return sexualHistoryQn;
  }

  /// Finds labInvestigationTests by [personInvestigationId]
  Future<List<SexualHistoryQuestionTable>> findBySexualHistoryId(String sexualHistoryId) async {
    Find finder = new Find(tableName);
    finder.where(this.sexualHistoryId.eq(sexualHistoryId));
    List<Map> maps = await (await _adapter.find(finder)).toList();
    List<SexualHistoryQuestionTable> sexualHistoryQnList = new List<SexualHistoryQuestionTable>();
    for (Map map in maps) {
      var sexualHistoryQn = SexualHistoryQuestionTable.fromJson(map);
      sexualHistoryQnList.add(sexualHistoryQn);
    }
    return sexualHistoryQnList;
  }

  /// Finds all sexualHistoryQns
  Future<List<SexualHistoryQuestionTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    List<SexualHistoryQuestionTable> sexualHistoryQnList = new List<SexualHistoryQuestionTable>();

    for (Map map in maps) {
      var sexualHistoryQn = SexualHistoryQuestionTable.fromJson(map);
      sexualHistoryQnList.add(sexualHistoryQn);
    }
    return sexualHistoryQnList;
  }

  Future insertFromEhr(Map map,String sexualHistory) async {

    Insert inserter = new Insert(tableName);

    inserter.set(id, map['sexualHistoryQuestionId']);
    inserter.set(sexualHistoryId, sexualHistory);
    inserter.set(responseType, map['question']['responseType']);

    inserter.set(code, map['question']['id']);
    inserter.set(name, map['question']['name']);

    inserter.set(status,'IMPORTED');

    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}