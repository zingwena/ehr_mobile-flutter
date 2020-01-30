

class AuthorityTable {
  int id;
  int userId;
  String authority;
  AuthorityTable fromJson(Map map) {
    var obj = AuthorityTable();
    obj.id = map['id'];
    obj.userId=map['userId'];
    obj.authority=map['authority'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'userId':userId,
    'authority':authority,
    'id':id,
  };

}