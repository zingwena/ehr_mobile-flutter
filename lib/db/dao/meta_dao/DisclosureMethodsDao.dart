
import 'package:ehr_mobile/db/tables/meta_tables/DisclosureMethodTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import '../base_dao.dart';

class DisclosureMethodDao  extends BaseDao {

  var name = new StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'DisclosureMethod';
  DisclosureMethodDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [id]
  Future<DisclosureMethodTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var status = DisclosureMethodTable().fromJson(map);
    return status;
  }

  /// Finds all
  Future<List<DisclosureMethodTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<DisclosureMethodTable>();

    for (Map map in maps) {
      var status = DisclosureMethodTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(id, map['id']);
    inserter.set(name, map['name']);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}