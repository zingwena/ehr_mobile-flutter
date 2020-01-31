
import 'package:ehr_mobile/db/dao/base_dao.dart';
import 'package:ehr_mobile/db/tables/meta_tables/ArvCombinationRegimenTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class ArvCombinationRegimenDao extends BaseDao{

  var regimenType = new StrField('regimenType');
  var ageGroup = new StrField('ageGroup');
  var code = new StrField('code');
  var name = new StrField('name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'ArvCombinationRegimen';
  ArvCombinationRegimenDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [id]
  Future<ArvCombinationRegimenTable> findById(String code) async {
    Find param = new Find(tableName);

    param.where(this.code.eq(code));

    Map map = await _adapter.findOne(param);

    var status = ArvCombinationRegimenTable().fromJson(map);
    return status;
  }

  /// Finds all
  Future<List<ArvCombinationRegimenTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<ArvCombinationRegimenTable>();

    for (Map map in maps) {
      var status = ArvCombinationRegimenTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(regimenType, map['regimenType']);
    inserter.set(ageGroup, map['arvAgeGroup']);
    inserter.set(code, map['arvCombinationRegimenId']);
    inserter.set(name, map['name']);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}