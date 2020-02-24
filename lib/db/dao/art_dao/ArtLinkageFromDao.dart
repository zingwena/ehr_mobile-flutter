
import 'package:ehr_mobile/util/RecordStatusConstants.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import '../base_dao.dart';

class ArtLinkageFromDao extends BaseDao{

  var artId = new StrField('artId');
  var linkageFrom = new StrField('linkageFrom');
  var linkageNumber = new StrField('linkageNumber');

  var dateHivConfirmed = new DateTimeField('dateHivConfirmed');

  var otherInstitution = new StrField('otherInstitution');
  var hivTestUsed = new StrField('hivTestUsed');


  var testReason_code = new StrField('testReason_code');
  var testReason_name = new StrField('testReason_name');

  var reTested = new IntField('reTested');

  var dateRetested = new DateTimeField('dateRetested');

  var facility_code = new StrField('facility_code');
  var facility_name = new StrField('facility_name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'ArtLinkageFrom';
  ArtLinkageFromDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, SYNCHED);
    var result=await _adapter.update(updater);
    return result;
  }


  Future insertFromEhr(Map map,String art) async {
    Insert inserter = new Insert(tableName);
    inserter.set(id, map['artLinkageFromId']);
    inserter.set(artId, art);

    inserter.set(linkageFrom, map['linkageFrom']);
    inserter.set(linkageNumber, map['linkageNumber']);

    inserter.set(dateHivConfirmed,const CustomDateTimeConverter().fromEhrJson( map['dateHivConfirmed']));
    inserter.set(otherInstitution, map['otherInstitution']);
    inserter.set(hivTestUsed, map['hivTestUsed']);
    inserter.set(reTested, map['reTested']);


    inserter.set(dateRetested,const CustomDateTimeConverter().fromEhrJson(map['dateRetested']));

    if(map['testReason']!=null){
      inserter.set(testReason_code,map['testReason']['id']);
      inserter.set(testReason_name,map['testReason']['name']);
    }

    if(map['facility']!=null){
      inserter.set(facility_code,map['facility']['id']);
      inserter.set(facility_name,map['facility']['name']);
    }

    inserter.set(status, 'IMPORTED');
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}

