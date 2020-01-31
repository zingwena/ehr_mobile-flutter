
import 'package:ehr_mobile/db/tables/meta_tables/MedicineNameTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class MedicineNameDao {

  var medicineCategory = new StrField('medicineCategory');
  var medicineLevel = new StrField('medicineLevel');
  var otc = new IntField('otc');
  var code = new StrField('code');
  var name = new StrField('name');

  SqfliteAdapter _adapter;
  String get tableName => 'MedicineName';

  MedicineNameDao (SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [code]
  Future<MedicineNameTable> findById(String code) async {
    Find param = new Find(tableName);

    param.where(this.code.eq(code));

    Map map = await _adapter.findOne(param);

    var status = MedicineNameTable().fromJson(map);
    return status;
  }


  Future<MedicineNameTable> findByName(String name) async {
    Find param = new Find(tableName);

    param.where(this.name.eq(name));

    Map map = await _adapter.findOne(param);
    if(map==null || map.isEmpty){
      return null;
    }
    var status = MedicineNameTable().fromJson(map);
    return status;
  }

  /// Finds all
  Future<List<MedicineNameTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<MedicineNameTable>();

    for (Map map in maps) {
      var status = MedicineNameTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(code, map['code']);
    inserter.set(name, map['name']);

    inserter.set(medicineCategory, map['medicineCategory']);
    inserter.set(medicineLevel, map['medicineLevel']);
    inserter.set(otc, 1);

    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }
}