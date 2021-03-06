
import 'package:ehr_mobile/db/tables/hts/index_test_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import '../base_dao.dart';

class IndexTestDao extends BaseDao{

  var personId = new StrField('personId');
  var date = new DateTimeField('date');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'IndexTest';
  IndexTestDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds one indexTest by [personId]
  Future<IndexTestTable> findByPersonId(String personId) async {
    Find param = new Find(tableName);

    param.where(this.personId.eq(personId));

    Map map = await _adapter.findOne(param);
    if(map!=null && map.isNotEmpty){
      var indexTest = IndexTestTable.fromJson(map);
      return indexTest;
    }
    return null;
  }

  /// Finds all persons
  Future<List<IndexTestTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    List<IndexTestTable> indexTests = new List<IndexTestTable>();

    for (Map map in maps) {
      var indexTest = IndexTestTable.fromJson(map);
      indexTests.add(indexTest);
    }
    return indexTests;
  }
}