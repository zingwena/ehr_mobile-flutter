


import 'package:ehr_mobile/db/dao/base_dao.dart';
import 'package:ehr_mobile/db/tables/art/ArtIptTable.dart';
import 'package:ehr_mobile/util/RecordStatusConstants.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class ArtIptDao extends BaseDao {

  var artId = new StrField('artId');
  var date = new StrField('date');
  var status_code = new StrField('status_code');
  var status_name = new StrField('status_name');
  var reason_code = new StrField('reason_code');
  var reason_name = new StrField('reason_name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'ArtIpt';
  ArtIptDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, SYNCHED);
    var result=await _adapter.update(updater);
    return result;
  }


  Future<ArtIptTable> findByArtId(String artId) async {
    Find param = new Find(tableName);
    param.where(this.artId.eq(artId));
    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var artIpt = ArtIptTable.fromJson(map);
    return artIpt;
  }


  Future insertFromEhr(Map map,String art) async {
    Insert inserter = new Insert(tableName);
    inserter.set(id, map['artIptStatusId']);
    inserter.set(artId, art);

    inserter.set(date, const CustomDateTimeConverter().fromEhrJson(map['date']));

    if(map['status']!=null){
      inserter.set(status_code,map['status']['id']);
      inserter.set(status_name,map['status']['name']);
    }

    if(map['reason']!=null){
      inserter.set(reason_code,map['reason']['id']);
      inserter.set(reason_name,map['reason']['name']);
    }

    inserter.set(status, 'IMPORTED');
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }
}