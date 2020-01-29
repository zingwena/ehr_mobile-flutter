
import 'package:ehr_mobile/db/tables/meta_tables/ReligionTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';


class ReligionDao {

  var code = new StrField('code');
  var name = new StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Religion';
  ReligionDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [code]
  Future<ReligionTable> findById(String code) async {
    Find param = new Find(tableName);

    param.where(this.code.eq(code));

    Map map = await _adapter.findOne(param);

    var status = ReligionTable().fromJson(map);
    return status;
  }


  Future<ReligionTable> findByName(String name) async {
    Find param = new Find(tableName);

    param.where(this.name.eq(name));

    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var status = ReligionTable().fromJson(map);
    return status;
  }

  /// Finds all visits
  Future<List<ReligionTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<ReligionTable>();

    for (Map map in maps) {
      var status = ReligionTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(code, map['code']);
    inserter.set(name, map['name']);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}