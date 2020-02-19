
import 'package:ehr_mobile/db/tables/art_table.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import '../base_dao.dart';

class ArtDao extends BaseDao{

  var personId = new StrField('personId');
  var artNumber = new StrField('artNumber');

  var dateEnrolled = new DateTimeField('dateEnrolled');
  var dateOfHivTest = new DateTimeField('dateOfHivTest');
  var date = new DateTimeField('date');
  var enlargedLymphNode= BoolField('enlargedLymphNode');
  var pallor= BoolField('pallor');

  var jaundice=BoolField('jaundice');
  var cyanosis=BoolField('cyanosis');
  var mentalStatus=StrField('mentalStatus');
  var centralNervousSystem=StrField('centralNervousSystem');

  var tracing=BoolField('tracing');
  var followUp=BoolField('followUp');
  var hivStatus=BoolField('hivStatus');

  var relation=StrField('relation');
  var dateOfDisclosure=StrField('dateOfDisclosure');
  var reason=StrField('reason');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Art';
  ArtDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds Art by [id]
  Future<ArtTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var art = ArtTable.fromJson(map);
    return art;
  }


  Future<ArtTable> findByPersonId(String personId) async {
    Find param = new Find(tableName);
    param.where(this.personId.eq(personId));
    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var art = ArtTable.fromJson(map);
    return art;
  }

  /// Finds all Art
  Future<List<ArtTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    List<ArtTable> arts = new List<ArtTable>();

    for (Map map in maps) {
      var art = ArtTable.fromJson(map);
      arts.add(art);
    }
    return arts;
  }

  Future insertFromEhr(Map map,String ehrPersonId) async {

    Insert inserter = new Insert(tableName);
    inserter.set(personId,ehrPersonId);
    inserter.set(id, map['artId']);
    inserter.set(artNumber, map['artNumber']);
    if (map['dateEnrolled'] != null) {
      inserter.set(dateEnrolled,const CustomDateTimeConverter().fromEhrJson( map['dateEnrolled']));
    }

    if (map['dateOfHivTest'] != null) {
      inserter.set(dateOfHivTest,const CustomDateTimeConverter().fromEhrJson(map['dateOfHivTest']));
    }

    if (map['date'] != null) {
      inserter.set(date,const CustomDateTimeConverter().fromEhrJson(map['date']));
    }

    if (map['enlargedLymphNode']!=null) inserter.set(enlargedLymphNode,map['enlargedLymphNode']);
    if (map['pallor']!=null) inserter.set(pallor,map['pallor']);
    if (map['jaundice']!=null) inserter.set(jaundice,map['jaundice']);
    if (map['cyanosis']!=null) inserter.set(cyanosis,map['cyanosis']);

    inserter.set(mentalStatus,map['mentalStatus']);
    inserter.set(centralNervousSystem,map['centralNervousSystem']);

    if (map['tracing']!=null) inserter.set(tracing,map['tracing']);
    if (map['followUp']!=null) inserter.set(followUp,map['followUp']);
    if (map['hivStatus']!=null) inserter.set(hivStatus,map['hivStatus']);

    inserter.set(relation,map['relation']);

    if (map['dateOfDisclosure'] != null) {
      inserter.set(dateOfDisclosure,const CustomDateTimeConverter().fromEhrJson(map['dateOfDisclosure']));
    }

    inserter.set(reason,map['reason']);

    inserter.set(status, 'IMPORTED');
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}