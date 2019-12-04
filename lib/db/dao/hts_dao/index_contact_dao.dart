
import 'package:ehr_mobile/db/dao/base_dao.dart';
import 'package:ehr_mobile/db/tables/hts/index_contact_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class IndexContactDao extends BaseDao{

  var indexTestId = new StrField('indexTestId');
  var personId = new StrField('personId');

  var relation = new StrField('relation');
  var hivStatus = new StrField('hivStatus');
  var dateOfHivStatus = new DateTimeField('dateOfHivStatus');
  var fearOfIpv = new IntField('fearOfIpv');

  var disclosureMethodPlanId = new StrField('disclosureMethodPlanId');
  var testingPlanId = new StrField('testingPlanId');
  var disclosureStatus = new StrField('disclosureStatus');
  var disclosureMethodId = new StrField('disclosureMethodId');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'IndexContact';
  IndexContactDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds one indexContact by [indexTestId]
  Future<List<IndexContactTable>> findByIndexTestId(String indexTestId) async {
    Find param = new Find(tableName);
    param.where(this.indexTestId.eq(indexTestId));

    List<Map> contacts = await _adapter.find(param);

    List<IndexContactTable> indexes=[];
    for(Map map in contacts){
      indexes.add(IndexContactTable.fromJson(map));
    }
    return indexes;
  }

  /// Finds all indexContacts
  Future<List<IndexContactTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    List<IndexContactTable> indexContacts = new List<IndexContactTable>();

    for (Map map in maps) {
      var indexContact = IndexContactTable.fromJson(map);
      indexContacts.add(indexContact);
    }
    return indexContacts;
  }
}