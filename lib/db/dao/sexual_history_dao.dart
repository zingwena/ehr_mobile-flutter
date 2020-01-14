
import 'package:ehr_mobile/db/tables/sexual_history_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class SexualHistoryDao extends BaseDao{

  var personId = new StrField('personId');
  var sexuallyActive = new IntField('sexuallyActive');
  var sexWithMaleDate = new DateTimeField('sexWithMaleDate');
  var sexWithFemaleDate = new DateTimeField('sexWithFemaleDate');

  var date = new DateTimeField('date');

  var numberOfSexualPartners = new IntField('numberOfSexualPartners');
  var numberOfSexualPartnersLastTwelveMonths = new IntField('numberOfSexualPartnersLastTwelveMonths');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'SexualHistory';
  SexualHistoryDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds sexualHistory by [id]
  Future<SexualHistoryTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var sexualHistory = SexualHistoryTable.fromJson(map);
    return sexualHistory;
  }


  Future<SexualHistoryTable> findByPersonId(String personId) async {
    Find param = new Find(tableName);

    param.where(this.personId.eq(personId));

    Map map = await _adapter.findOne(param);

    var sexualHistory = SexualHistoryTable.fromJson(map);
    return sexualHistory;
  }

  /// Finds all sexualHistory
  Future<List<SexualHistoryTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    List<SexualHistoryTable> sexualHistoryList = new List<SexualHistoryTable>();

    for (Map map in maps) {
      var sexualHistory = SexualHistoryTable.fromJson(map);
      sexualHistoryList.add(sexualHistory);
    }
    return sexualHistoryList;
  }

}