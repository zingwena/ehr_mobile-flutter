
import 'package:ehr_mobile/db/tables/art/ArtSymptomTable.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import '../base_dao.dart';

class ArtSymptomDao extends BaseDao{

  var artId = new StrField('artId');
  var code = new StrField('code');
  var name = new StrField('name');
  var date = new DateTimeField('date');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'ArtSymptom';
  ArtSymptomDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  Future<ArtSymptomTable> findByArtId(String artId) async {
    Find param = new Find(tableName);
    param.where(this.artId.eq(artId));
    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var artSymptom = ArtSymptomTable.fromJson(map);
    return artSymptom;
  }

  Future insertFromEhr(Map map,String art) async {

    Insert inserter = new Insert(tableName);
    inserter.set(artId, art);
    inserter.set(id, map['artSymptomId']);
    inserter.set(date,const CustomDateTimeConverter().fromEhrJson(map['date']));
    inserter.set(code,map['Symptom']['id']);
    inserter.set(name,map['Symptom']['name']);
    inserter.set(status, 'IMPORTED');
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}