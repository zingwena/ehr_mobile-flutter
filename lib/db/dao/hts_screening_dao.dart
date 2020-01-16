
import 'package:ehr_mobile/db/tables/hts_screening_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class HtsScreeningDao extends BaseDao{

  var visitId = new StrField('visitId');
  var testedBefore = new IntField('testedBefore');
  var art = new IntField('art');

  var result = new StrField('result');
  var dateLastTested = new DateTimeField('dateLastTested');
  var dateLastNegative = new DateTimeField('dateLastNegative');

  var artNumber = new StrField('artNumber');
  var viralLoadDone = new IntField('viralLoadDone');
  var cd4Done = new IntField('cd4Done');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'HtsScreening';
  HtsScreeningDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds HtsScreening by [id]
  Future<HtsScreeningTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var htsScreening = HtsScreeningTable.fromJson(map);
    return htsScreening;
  }


  Future<HtsScreeningTable> findByVisitId(String visitId) async {
    Find param = new Find(tableName);

    param.where(this.visitId.eq(visitId));

    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var sexualHistory = HtsScreeningTable.fromJson(map);
    return sexualHistory;
  }

  /// Finds all HtsScreening
  Future<List<HtsScreeningTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    List<HtsScreeningTable> htsScreenings = new List<HtsScreeningTable>();

    for (Map map in maps) {
      var htsScreening = HtsScreeningTable.fromJson(map);
      htsScreenings.add(htsScreening);
    }
    return htsScreenings;
  }

}