
import 'package:ehr_mobile/db/tables/meta_tables/town_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';


class TownDao {

  var code = new StrField('code');
  var name = new StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Town';
  TownDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds town by [code]
  Future<TownTable> findById(String code) async {
    Find param = new Find(tableName);

    param.where(this.code.eq(code));

    Map map = await _adapter.findOne(param);

    var town = TownTable().fromJson(map);
    return town;
  }


  Future<TownTable> findByName(String name) async {
    Find param = new Find(tableName);

    param.where(this.name.eq(name));

    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var town = TownTable().fromJson(map);
    return town;
  }

  /// Finds all visits
  Future<List<TownTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var towns = new List<TownTable>();

    for (Map map in maps) {
      var town = TownTable().fromJson(map);
      towns.add(town);
    }
    return towns;
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