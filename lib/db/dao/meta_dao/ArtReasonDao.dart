
import 'package:ehr_mobile/db/dao/base_dao.dart';
import 'package:ehr_mobile/db/tables/meta_tables/ArtReasonTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';


class ArtReasonDao extends BaseDao{

  var artStatusId = new StrField('artStatusId');
  var code = new StrField('code');
  var name = new StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'ArtReason';
  ArtReasonDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [id]
  Future<ArtReasonTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var status = ArtReasonTable().fromJson(map);
    return status;
  }

  /// Finds all
  Future<List<ArtReasonTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<ArtReasonTable>();

    for (Map map in maps) {
      var status = ArtReasonTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(artStatusId, map['artStatusId']);
    inserter.set(code, map['code']);
    inserter.set(name, map['name']);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}