

import 'package:ehr_mobile/db/dao/base_dao.dart';
import 'package:ehr_mobile/db/tables/art/ArtOI.dart';
import 'package:ehr_mobile/util/RecordStatusConstants.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class ArtOIDao extends BaseDao{

  var artId = new StrField('artId');
  var date = new DateTimeField('date');

  var code = new StrField('code');
  var name = new StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'ArtOi';
  ArtOIDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, SYNCHED);
    var result=await _adapter.update(updater);
    return result;
  }

  Future<ArtOITable> findByArtId(String artId) async {
    Find param = new Find(tableName);
    param.where(this.artId.eq(artId));
    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var artOI = ArtOITable.fromJson(map);
    return artOI;
  }


  Future insertFromEhr(Map map,String art) async {
    Insert inserter = new Insert(tableName);
    inserter.set(id, map['artOiId']);
    inserter.set(artId, art);
    inserter.set(date, const CustomDateTimeConverter().fromEhrJson(map['date']));

    if(map['oi']!=null){
      inserter.set(code,map['oi']['id']);
      inserter.set(name,map['oi']['name']);
    }

    inserter.set(status, 'IMPORTED');
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }
}