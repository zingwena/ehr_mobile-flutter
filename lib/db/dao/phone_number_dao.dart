
import 'package:ehr_mobile/db/tables/phone_number_table.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class PhoneNumberDao extends BaseDao{

  var phoneNumber1 = new StrField('phoneNumber1');
  var phoneNumber2 = new StrField('phoneNumber2');
  var personId = new StrField('personId');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'PersonPhone';
  PhoneNumberDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds one by [id]
  Future<PhoneNumberTable> findOne(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var phone = PhoneNumberTable.fromJson(map);
    return phone;
  }

  /// Finds one person by [id]
  Future<PhoneNumberTable> findByPersonId(String personId) async {
    Find param = new Find(tableName);

    param.where(this.personId.eq(personId));

    Map map = await _adapter.findOne(param);

    if(map==null){
      return null;
    }
    var phone = PhoneNumberTable.fromJson(map);
    return phone;
  }

}
