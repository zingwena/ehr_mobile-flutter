
import 'package:ehr_mobile/util/RecordStatusConstants.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import '../base_dao.dart';

class ArtWhoStageDao extends BaseDao {

  var artId = new StrField('artId');
  var visitId = new StrField('visitId');
  var stage =new StrField('stage');

  var code =new StrField('code');
  var name =new StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'ArtWhoStage';
  ArtWhoStageDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, SYNCHED);
    var result=await _adapter.update(updater);
    return result;
  }

  Future insertFromEhr(Map map,String art_id,String visit_Id) async {

    Insert inserter = new Insert(tableName);
    inserter.set(artId, art_id);
    inserter.set(id, map['artStageId']);
    inserter.set(visitId, visit_Id);

    inserter.set(stage, map['stage']);

    if (map['followUpStatus']!= null) {
      inserter.set(code, map['followUpStatus']['id']);
      inserter.set(name, map['followUpStatus']['name']);
    }


    inserter.set(status, 'IMPORTED');
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}
