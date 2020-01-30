

import 'package:ehr_mobile/db/tables/meta_tables/SiteSettingTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class SiteSettingDao {

  var id = new StrField('id');
  var name = new StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'SiteSetting';
  SiteSettingDao(SqfliteAdapter _adapter){
  this._adapter=_adapter;
  }

  /// Finds by [code]
  Future<SiteSettingTable> findById(String id) async {
  Find param = new Find(tableName);

  param.where(this.id.eq(id));

  Map map = await _adapter.findOne(param);

  var status = SiteSettingTable().fromJson(map);
  return status;
  }


  Future<SiteSettingTable> findByName(String name) async {
  Find param = new Find(tableName);

  param.where(this.name.eq(name));

  Map map = await _adapter.findOne(param);
  if(map==null || map.isEmpty){
  return null;
  }
  var status = SiteSettingTable().fromJson(map);
  return status;
  }

  Future insertFromEhr(Map map) async {
  Insert inserter = new Insert(tableName);
  inserter.set(id, map['siteId']);
  inserter.set(name, map['name']);
  return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
  Remove deleter = new Remove(tableName);
  return await _adapter.remove(deleter);
  }

}