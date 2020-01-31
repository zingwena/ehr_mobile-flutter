
import 'package:ehr_mobile/db/tables/meta_tables/TestKitLevelTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';


class TestKitLevelDao {

  var testKitId = new StrField('testKitId');
  var testLevel = new StrField('testLevel');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'TestKitTestLevel';
  TestKitLevelDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [testKitId]
  Future<TestKitLevelTable> findById(String testKitId) async {
    Find param = new Find(tableName);

    param.where(this.testKitId.eq(testKitId));

    Map map = await _adapter.findOne(param);

    var status = TestKitLevelTable().fromJson(map);
    return status;
  }


  /// Finds all
  Future<List<TestKitLevelTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<TestKitLevelTable>();

    for (Map map in maps) {
      var status = TestKitLevelTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(String testKit,String tl) async {
    Insert inserter = new Insert(tableName);
    inserter.set(testKitId, testKit);
    inserter.set(testLevel, tl);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}