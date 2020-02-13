

import 'package:ehr_mobile/db/tables/art/ArtCurrentStatusTable.dart';
import 'package:ehr_mobile/util/RecordStatusConstants.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import '../base_dao.dart';

class ArtCurrentStatusDao extends BaseDao {

  var date = new DateTimeField('date');
  var artId = new StrField('artId');
  var regimen_code = new StrField('regimen_code');
  var regimen_name = new StrField('regimen_name');

  var state = new StrField('state');

  var reason_code = new StrField('reason_code');
  var reason_name = new StrField('reason_name');

  var regimenType = new StrField('regimenType');

  var adverseEventStatus_code = new StrField('adverseEventStatus_code');
  var adverseEventStatus_name = new StrField('adverseEventStatus_name');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'ArtCurrentStatus';

  ArtCurrentStatusDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }


  /// Finds all Art
  Future<List<ArtCurrentStatusTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    List<ArtCurrentStatusTable> arts = new List<ArtCurrentStatusTable>();

    for (Map map in maps) {
      var art = ArtCurrentStatusTable.fromJson(map);
      arts.add(art);
    }
    return arts;
  }

  Future insertFromEhr(Map map,String art) async {
    Insert inserter = new Insert(tableName);
    inserter.set(id, map['artStatusId']);
    inserter.set(artId, art);
    inserter.set(date,const CustomDateTimeConverter().fromEhrJson( map['date']));
    inserter.set(regimenType,map['regimenType']);

    inserter.set(state,map['state']);

    inserter.set(status, IMPORTED);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}