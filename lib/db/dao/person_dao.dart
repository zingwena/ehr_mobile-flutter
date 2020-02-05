
import 'package:ehr_mobile/db/tables/person_table.dart';
import 'package:ehr_mobile/model/enums/enums.dart';
import 'package:ehr_mobile/util/custom_convertor.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'base_dao.dart';

class PersonDao extends BaseDao{

  var firstName = new StrField('firstName');
  var lastName = new StrField('lastName');

  var sex = new StrField('sex');
  var nationalId = new StrField('nationalId');
  final DateTimeField birthDate = new DateTimeField('birthDate');

  var selfIdentifiedGender = new StrField('selfIdentifiedGender');
  var religionId = new StrField('religionId');
  var occupationId = new StrField('occupationId');

  var maritalStatusId = new StrField('maritalStatusId');
  var educationLevelId = new StrField('educationLevelId');
  var nationalityId = new StrField('nationalityId');
  var countryId = new StrField('countryId');

  var street = new StrField('street');
  var suburbVillage = new StrField('suburbVillage');
  var town = new StrField('town');
  var city = new StrField('city');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'Person';
  PersonDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  Future<int> setSyncd(String id) async {
    Update updater = new Update(tableName);
    updater.where(this.id.eq(id));
    updater.set(this.status, '2');
    var result=await _adapter.update(updater);
    return result;
  }

  /// Finds one person by [id]
  Future<PersonTable> findOne(String id) async {
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var person = PersonTable.fromJson(map);
    return person;
  }

  /// Finds all persons
  Future<List<PersonTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = await (await _adapter.find(finder)).toList();

    List<PersonTable> persons = new List<PersonTable>();

    for (Map map in maps) {
      var person = PersonTable.fromJson(map);
      persons.add(person);
    }
    return persons;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(id, map['personId']);
    inserter.set(firstName, map['firstname']);
    inserter.set(lastName, map['lastname']);

    inserter.set(sex, map['sex']);
    inserter.set(nationalId, map['identifications'][0]['number']);
    inserter.set(birthDate, const CustomDateTimeConverter().fromEhrJson(map['birthdate']));

    inserter.set(selfIdentifiedGender, map['selfIdentifiedGender']);
    inserter.set(religionId, map['religion']['id']);
    inserter.set(occupationId, map['occupation']['id']);

    inserter.set(maritalStatusId, map['marital']['id']);
    inserter.set(educationLevelId, map['education']['id']);
    inserter.set(nationalityId, map['nationality']['id']);
    inserter.set(status,'IMPORTED');

    if(map['countryOfBirth']!=null)
    inserter.set(countryId, map['countryOfBirth']['id']);

    if(map['address']!=null){
      inserter.set(street, map['address']['street']);
      inserter.set(town, map['address']['town']['name']);
      inserter.set(city, map['address']['city']);
    }
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}