
import 'package:ehr_mobile/db/dao/base_dao.dart';
import 'package:ehr_mobile/db/tables/meta_tables/InvestigationTable.dart';
import 'package:ehr_mobile/model/enums/enums.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';


class InvestigationDao extends BaseDao{

  var laboratoryTestId = new StrField('laboratoryTestId');
  var sampleId = new StrField('sampleId');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Investigation';
  InvestigationDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [id]
  Future<InvestigationTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var status = InvestigationTable().fromJson(map);
    return status;
  }

  /// Finds all
  Future<List<InvestigationTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<InvestigationTable>();

    for (Map map in maps) {
      var status = InvestigationTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(laboratoryTestId, map['laboratoryTestId']);
    inserter.set(sampleId, map['sampleId']);
    inserter.set(id, map['investigationId']);
    inserter.set(status,'${RecordStatus.IMPORTED.toString()}');
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}