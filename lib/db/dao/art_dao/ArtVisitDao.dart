

import 'package:ehr_mobile/db/dao/base_dao.dart';
import 'package:ehr_mobile/util/RecordStatusConstants.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:ehr_mobile/util/logger.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class ArtVisitDao extends BaseDao {

  var artId = new StrField('artId');
  var visitId = new StrField('visitId');

  var visitType_code = new StrField('visitType_code');
  var visitType_name = new StrField('visitType_name');

  var functionalStatus_code = new StrField('functionalStatus_code');
  var functionalStatus_name = new StrField('functionalStatus_name');

  var visitStatus_code = new StrField('visitStatus_code');
  var visitStatus_name = new StrField('visitStatus_name');

  var ancFirstBookingDate = new DateTimeField('ancFirstBookingDate');

  var lactatingStatus_code = new StrField('lactatingStatus_code');
  var lactatingStatus_name = new StrField('lactatingStatus_name');

  var familyPlanningStatus_code = new StrField('familyPlanningStatus_code');
  var familyPlanningStatus_name = new StrField('familyPlanningStatus_name');

  var tbStatus_code = new StrField('tbStatus_code');
  var tbStatus_name = new StrField('tbStatus_name');

  //var date = new DateTimeField('date');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'ArtVisit';
  ArtVisitDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, IMPORTED);
    var result=await _adapter.update(updater);
    return result;
  }

  Future insertFromEhr(Map map,String art) async {
    Insert inserter = new Insert(tableName);
    inserter.set(artId, art);
    inserter.set(id, map['visitId']);
    inserter.set(visitId, map['visitId']);

    if (map['visitType'] != null) {
      inserter.set(visitType_code, map['visitType']['id']);
      inserter.set(visitType_name, map['visitType']['name']);
    }

    if (map['familyPlanningStatus'] != null) {
      inserter.set(functionalStatus_code, map['familyPlanningStatus']['id']);
      inserter.set(functionalStatus_name, map['familyPlanningStatus']['name']);
    }

    if (map['visitStatus'] != null) {
      inserter.set(visitStatus_code, map['visitStatus']['id']);
      inserter.set(visitStatus_name, map['visitStatus']['name']);
    }

    if (map['ancFirstBookingDate'] != null) {
      inserter.set(ancFirstBookingDate,const CustomDateTimeConverter().fromEhrJson(map['ancFirstBookingDate']));
    }

    if (map['lactatingStatus'] != null) {
      inserter.set(lactatingStatus_code, map['lactatingStatus']['id']);
      inserter.set(lactatingStatus_name, map['lactatingStatus']['name']);
    }

    if (map['familyPlanningStatus'] != null) {
      inserter.set(familyPlanningStatus_code, map['familyPlanningStatus']['id']);
      inserter.set(familyPlanningStatus_name, map['familyPlanningStatus']['name']);
    }

    if(map['tbStatus']!=null){
      inserter.set(tbStatus_code, map['tbStatus']['id']);
      inserter.set(tbStatus_name, map['tbStatus']['name']);
    }

    //inserter.set(date, map['date']);

    inserter.set(status, 'IMPORTED');
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}