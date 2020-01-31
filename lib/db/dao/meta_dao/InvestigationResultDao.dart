
import 'package:ehr_mobile/db/dao/base_dao.dart';
import 'package:ehr_mobile/db/tables/meta_tables/InvestigationResultTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';


class InvestigationResultDao extends BaseDao{

  var resultId = new StrField('resultId');
  var investigationId = new StrField('investigationId');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'InvestigationResult';
  InvestigationResultDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [id]
  Future<InvestigationResultTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var status = InvestigationResultTable().fromJson(map);
    return status;
  }

  /// Finds all
  Future<List<InvestigationResultTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<InvestigationResultTable>();

    for (Map map in maps) {
      var status = InvestigationResultTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(resultId, map['resultId']);
    inserter.set(investigationId, map['investigationId']);
    inserter.set(id, map['id']);
    inserter.set(status,1);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}