
import 'package:ehr_mobile/db/tables/meta_tables/FacilityTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';


class FacilityDao {

  var code = new StrField('code');
  var name = new StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Facility';
  FacilityDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [code]
  Future<FacilityTable> findById(String code) async {
    Find param = new Find(tableName);

    param.where(this.code.eq(code));

    Map map = await _adapter.findOne(param);

    var status = FacilityTable().fromJson(map);
    return status;
  }


  Future<FacilityTable> findByName(String name) async {
    Find param = new Find(tableName);

    param.where(this.name.eq(name));

    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var status = FacilityTable().fromJson(map);
    return status;
  }

  /// Finds all visits
  Future<List<FacilityTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<FacilityTable>();

    for (Map map in maps) {
      var status = FacilityTable().fromJson(map);
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