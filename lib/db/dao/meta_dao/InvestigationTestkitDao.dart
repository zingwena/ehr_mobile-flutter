
import 'package:ehr_mobile/db/dao/base_dao.dart';
import 'package:ehr_mobile/db/tables/meta_tables/InvestigationTestkitTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';


class InvestigationTestkitDao extends BaseDao{

  var investigationId = new StrField('investigationId');
  var testKitId = new StrField('testKitId');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'InvestigationTestkit';
  InvestigationTestkitDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [id]
  Future<InvestigationTestkitTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var status = InvestigationTestkitTable().fromJson(map);
    return status;
  }

  /// Finds all
  Future<List<InvestigationTestkitTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<InvestigationTestkitTable>();

    for (Map map in maps) {
      var status = InvestigationTestkitTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(investigationId, map['investigationId']);
    inserter.set(testKitId, map['testKitId']);
    inserter.set(id, map['investigationTestKitId']);
    inserter.set(status,1);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}