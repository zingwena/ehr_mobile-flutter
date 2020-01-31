

import 'package:ehr_mobile/db/tables/meta_tables/AuthorityTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class AuthorityDao {

  var id = new IntField('id');
  var userId = new IntField('userId');
  var authority = new StrField('authority');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Authorities';
  AuthorityDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [id]
  Future<AuthorityTable> findById(int id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var status = AuthorityTable().fromJson(map);
    return status;
  }

  /// Finds all
  Future<List<AuthorityTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<AuthorityTable>();

    for (Map map in maps) {
      var status = AuthorityTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(int user,String auth) async {
    Insert inserter = new Insert(tableName);
    inserter.set(userId, user);
    inserter.set(authority, auth);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }
}