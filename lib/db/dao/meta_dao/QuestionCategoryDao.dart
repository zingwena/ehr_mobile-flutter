
import 'package:ehr_mobile/db/tables/meta_tables/QuestionCategoryTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';


class QuestionCategoryDao {

  var sortOrder = new IntField('sortOrder');
  var workArea = new StrField('workArea');
  var code = StrField('code');
  var name = StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'QuestionCategory';
  QuestionCategoryDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [id]
  Future<QuestionCategoryTable> findById(String code) async {
    Find param = new Find(tableName);

    param.where(this.code.eq(code));

    Map map = await _adapter.findOne(param);

    var status = QuestionCategoryTable().fromJson(map);
    return status;
  }

  /// Finds all
  Future<List<QuestionCategoryTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<QuestionCategoryTable>();

    for (Map map in maps) {
      var status = QuestionCategoryTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(sortOrder, map['sortOrder']);
    inserter.set(workArea, map['workArea']);
    inserter.set(code, map['questionCategoryId']);
    inserter.set(name,map['name']);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}