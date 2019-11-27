
import 'package:ehr_mobile/model/person.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class PersonDao {

  var id = new StrField('id');
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
  var status=new IntField('status');
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
    //await _adapter.close();
    return result;
  }

  /// Finds one person by [id]
  Future<Person> findOne(String id) async {
    //await _adapter.connect();
    Find param = new Find(tableName);

    param.where(this.id.eq(id));

    Map map = await _adapter.findOne(param);

    var person = Person.fromJson(map);
    //await _adapter.close();
    return person;
  }

  /// Finds all persons
  Future<List<Person>> findAll() async {
    //await _adapter.connect();
    Find finder = new Find(tableName);

    List<Map> maps = await (await _adapter.find(finder)).toList();

    List<Person> persons = new List<Person>();

    for (Map map in maps) {
      var person = Person.fromMap(map);
      persons.add(person);
    }
    //await _adapter.close();
    return persons;
  }

}