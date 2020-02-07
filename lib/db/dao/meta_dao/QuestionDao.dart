
import 'package:ehr_mobile/db/tables/meta_tables/QuestionTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';


class QuestionDao {

  var categoryId = new IntField('categoryId');
  var type = new StrField('type');
  var code = StrField('code');
  var name = StrField('name');
  var workArea = StrField('workArea');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Question';
  QuestionDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [id]
  Future<QuestionTable> findById(String code) async {
    Find param = new Find(tableName);

    param.where(this.code.eq(code));

    Map map = await _adapter.findOne(param);

    var status = QuestionTable().fromJson(map);
    return status;
  }

  /// Finds all
  Future<List<QuestionTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<QuestionTable>();

    for (Map map in maps) {
      var status = QuestionTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(categoryId, map['categoryId']);
    inserter.set(type, map['type']);
    inserter.set(code, map['questionId']);
    inserter.set(name,map['name']);
    inserter.set(workArea,map['workArea']);
    return _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}