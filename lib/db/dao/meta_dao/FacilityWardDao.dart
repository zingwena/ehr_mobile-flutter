
import 'package:ehr_mobile/db/tables/meta_tables/FacilityWardTable.dart';
import 'package:ehr_mobile/util/RecordStatusConstants.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class FacilityWardDao {

  var id=StrField('id');
  var ward_code=StrField('ward_code');
  var ward_name=StrField('ward_name');

  var facility_code=StrField('facility_code');
  var facility_name=StrField('facility_name');

  var department_code=StrField('department_code');
  var department_name=StrField('department_name');

  var beds=IntField('beds');
  var status=IntField('status');


  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'FacilityWard';
  FacilityWardDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds all visits
  Future<List<FacilityWardTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<FacilityWardTable>();

    for (Map map in maps) {
      var status = FacilityWardTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(String wardId,String wardCode,String wardName, String deptCode,String deptName,int bed) async {
    Insert inserter = new Insert(tableName);

    inserter.set(id, wardId);
    inserter.set(ward_code, wardCode);
    inserter.set(ward_name, wardName);

    inserter.set(department_code, deptCode);
    inserter.set(department_name, deptName);

    inserter.set(beds, bed);
    inserter.set(status, IMPORTED);

    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}