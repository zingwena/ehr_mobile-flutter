
import 'package:ehr_mobile/db/tables/meta_tables/UserTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class UserDao {

  var ehrId = new StrField('ehrId');
  var login = new StrField('login');
  var firstName = new StrField('firstName');
  var lastName = new StrField('lastName');
  var email = new StrField('email');
  var imageUrl = new StrField('imageUrl');
  var activated = new StrField('activated');
  var langKey = new StrField('langKey');
  var createdBy = new StrField('createdBy');
  var createdDate = new DateTimeField('createdDate');
  var lastModifiedBy = new StrField('lastModifiedBy');
  var lastModifiedDate = new DateTimeField('lastModifiedDate');
  var userId = new IntField('userId');

  SqfliteAdapter _adapter;

  /// Table name for the model this bean manages
  String get tableName => 'User';
  UserDao(SqfliteAdapter _adapter){
    this._adapter=_adapter;
  }

  /// Finds by [id]
  Future<UserTable> findById(String id) async {
    Find param = new Find(tableName);

    param.where(this.ehrId.eq(id));

    Map map = await _adapter.findOne(param);

    var status = UserTable().fromJson(map);
    return status;
  }

  /// Finds all
  Future<List<UserTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<UserTable>();

    for (Map map in maps) {
      var status = UserTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

  Future insertFromEhr(Map map) async {
    Insert inserter = new Insert(tableName);
    inserter.set(ehrId,map['id']);
    inserter.set(login, map['login']);
    inserter.set(firstName, map['firstName']);
    inserter.set(lastName, map['lastName']);
    inserter.set(email, map['email']);
    inserter.set(imageUrl, map['imageUrl']);
    inserter.set(activated, map['activated']);
    inserter.set(langKey, map['langKey']);
    inserter.set(createdBy, map['createdBy']);
    inserter.set(createdDate, map['createdDate']);
    inserter.set(lastModifiedBy, map['lastModifiedBy']);
    inserter.set(lastModifiedDate, map['lastModifiedDate']);
    inserter.set(userId,map['id']);
    return await _adapter.insert(inserter);
  }

  Future<int> removeAll() async {
    Remove deleter = new Remove(tableName);
    return await _adapter.remove(deleter);
  }

}