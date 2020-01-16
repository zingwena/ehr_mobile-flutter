
import 'package:ehr_mobile/db/tables/art_initiation_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class ArtInitiationDao extends BaseDao{

  var personId = new StrField('personId');
  var artRegimenId = new StrField('artRegimenId');
  var artReasonId = new StrField('artReasonId');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'ArtInitiation';
  ArtInitiationDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds Art by [id]
  Future<ArtInitiationTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var art = ArtInitiationTable.fromJson(map);
    return art;
  }


  Future<ArtInitiationTable> findByPersonId(String personId) async {
    Find param = new Find(tableName);
    param.where(this.personId.eq(personId));
    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var artInitiation = ArtInitiationTable.fromJson(map);
    return artInitiation;
  }

  /// Finds all Art
  Future<List<ArtInitiationTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    List<ArtInitiationTable> artInitiations = new List<ArtInitiationTable>();

    for (Map map in maps) {
      var artInitiation = ArtInitiationTable.fromJson(map);
      artInitiations.add(artInitiation);
    }
    return artInitiations;
  }

}