


import 'package:ehr_mobile/db/tables/art/ArtAppointmentTable.dart';
import 'package:ehr_mobile/util/RecordStatusConstants.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import '../base_dao.dart';

class ArtAppointmentDao  extends BaseDao{

  var artId = new StrField('artId');
  var reason_code = new StrField('reason_code');
  var reason_name = new StrField('reason_name');

  var date = new DateTimeField('date');

  var followUpReason_code = new StrField('followUpReason_code');
  var followUpReason_name = new StrField('followUpReason_name');

  var followupDate = new DateTimeField('followupDate');
  var appointmentOutcomeDate = new DateTimeField('appointmentOutcomeDate');

  var appointmentOutcome_code = new StrField('appointmentOutcome_code');
  var appointmentOutcome_name = new StrField('appointmentOutcome_name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'ArtAppointment';
  ArtAppointmentDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, SYNCHED);
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds Art by [id]
  Future<ArtAppointmentTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var art = ArtAppointmentTable.fromJson(map);
    return art;
  }
//
  Future<ArtAppointmentTable> findByArtId(String artId) async {
    Find param = new Find(tableName);
    param.where(this.artId.eq(artId));
    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var artAppointments = ArtAppointmentTable.fromJson(map);
    return artAppointments;
  }


  /// Finds all Art
  Future<List<ArtAppointmentTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    List<ArtAppointmentTable> arts = new List<ArtAppointmentTable>();

    for (Map map in maps) {
      var art = ArtAppointmentTable.fromJson(map);
      arts.add(art);
    }
    return arts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(id, map['artAppointmentId']);
    inserter.set(artId, map['artId']);
    inserter.set(date,const CustomDateTimeConverter().fromEhrJson( map['date']));

    inserter.set(followupDate,const CustomDateTimeConverter().fromEhrJson(map['followupDate']));
    if(map['appointmentOutcomeDate']!=null){
      inserter.set(appointmentOutcomeDate,const CustomDateTimeConverter().fromEhrJson(map['appointmentOutcomeDate']));
    }

    if(map['followupReason']!=null){
      inserter.set(followUpReason_code,map['followupReason']['id']);
      inserter.set(followUpReason_name,map['followupReason']['name']);
    }

    if(map['appointmentOutcome']!=null){
      inserter.set(appointmentOutcome_code,map['appointmentOutcome']['id']);
      inserter.set(appointmentOutcome_name,map['appointmentOutcome']['name']);
    }

    inserter.set(status, 'IMPORTED');
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}