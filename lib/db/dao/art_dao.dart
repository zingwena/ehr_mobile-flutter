
import 'package:ehr_mobile/db/tables/art_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class ArtDao extends BaseDao{

  var personId = new StrField('personId');
  var oiArtNumber = new StrField('oiArtNumber');

  var dateOfEnrolmentIntoCare = new DateTimeField('dateOfEnrolmentIntoCare');
  var dateOfHivTest = new DateTimeField('dateOfHivTest');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Art';
  ArtDao(SqfliteAdapter _adapter){
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
  Future<ArtTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var art = ArtTable.fromJson(map);
    return art;
  }


  Future<ArtTable> findByPersonId(String personId) async {
    Find param = new Find(tableName);
    param.where(this.personId.eq(personId));
    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var art = ArtTable.fromJson(map);
    return art;
  }

  /// Finds all Art
  Future<List<ArtTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    List<ArtTable> arts = new List<ArtTable>();

    for (Map map in maps) {
      var art = ArtTable.fromJson(map);
      arts.add(art);
    }
    return arts;
  }

}